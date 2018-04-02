require 'bundler'
Bundler.require()
require 'envyable'
Envyable.load('./config/env.yml', 'development')
require_relative './sms_machine.rb'

get '/' do
  'Sinatra has taking the stage.'
end

get '/send' do
  @return_info = SmsMachine.send_sms(ENV['MY_CELL_PHONE_NUMBER'],ENV['TWILIO_PHONE_NUMBER'],"This is a test of a text!")
  puts @return_info
end

post '/sms' do
  twiml = Twilio::TwiML::MessagingResponse.new do |r|
    r.message("This works - response!")
  end

  content_type "text/xml"

  twiml.to_s
end
