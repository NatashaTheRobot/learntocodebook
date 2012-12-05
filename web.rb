require 'sinatra'

get '/' do
  File.read(File.join('public', 'index.html'))
end

post '/charge' do
  # set your secret key: remember to change this to your live secret key in production
  # see your keys here https://manage.stripe.com/account
  Stripe.api_key = "sk_test_2XxS0Cu8cQ9hDEJUVzEp8j3Z"

  # get the credit card details submitted by the form
  token = params[:stripeToken]

  # create the charge on Stripe's servers - this will charge the user's card
  charge = Stripe::Charge.create(
    :amount => 995, # amount in cents, again
    :currency => "usd",
    :card => token,
    :description => "payinguser@example.com"
  )
end