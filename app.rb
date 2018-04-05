require 'bundler'
Bundler.require()
require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require 'envyable'
Envyable.load('./config/env.yml', 'development')
require './app/models/model'
require_relative './sms_machine.rb'

include SmsMachine

get '/' do
  'Sinatra has taken the stage.'
end

get '/send' do
  SmsFactory.send_sms(ENV['MY_CELL_PHONE_NUMBER'],ENV['TWILIO_PHONE_NUMBER'],"This is a test of a text!")
end

post '/sms' do
  number = params['From']
  body = params['Body']
  SmsFactory.respond_sms("What you sent me was: "+body)
end
