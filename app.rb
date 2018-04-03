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
  @return_info
end

post '/sms' do
  @send_info = SmsMachine.respond_sms("I am just testing the response")
end
