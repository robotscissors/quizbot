require 'bundler'
Bundler.require()
require 'envyable'
Envyable.load('./config/env.yml', 'development')


@client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"],ENV["TWILIO_AUTH_TOKEN"])
@client.messages.create(
  to: ENV['MY_CELL_PHONE_NUMBER'],
  from: ENV['TWILIO_PHONE_NUMBER'],
  body: "I want to make sure messages are going out. Check out this link http://robotscissors.com !"
)
