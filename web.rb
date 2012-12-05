require 'sinatra'
require 'stripe'

set :publishable_key, ENV['PUBLISHABLE_KEY']
set :secret_key, ENV['SECRET_KEY']

Stripe.api_key = settings.secret_key

get '/' do
  File.read(File.join('public', 'index.html'))
end

post '/charge' do
  # Amount in cents
  @amount = 995

  Stripe::Charge.create(
    :amount      => @amount,
    :card        => params[:stripeToken],
    :description => 'Sinatra Charge',
    :currency    => 'usd'
  )
  
  error Stripe::CardError do
    env['sinatra.error'].message
  end

  File.read(File.join('public', 'index.html'))
end