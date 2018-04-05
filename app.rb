require 'bundler'
Bundler.require()
require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require 'envyable'
Envyable.load('./config/env.yml', 'development')
require './app/models/model'
require_relative './sms_machine.rb'

get '/' do
  'Sinatra has taken the stage.'
end

get '/send' do
  @return_info = SmsMachine.send_sms(ENV['MY_CELL_PHONE_NUMBER'],ENV['TWILIO_PHONE_NUMBER'],"This is a test of a text!")
end

post '/sms' do
  @send_info = SmsMachine.respond_sms("I am just testing the response")
end
