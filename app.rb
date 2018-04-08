require 'bundler'
Bundler.require()
require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require 'envyable'
Envyable.load('./config/env.yml', 'development')
require_relative './app/models/user.rb'
require_relative './app/models/topic.rb'
require_relative './app/models/question.rb'
require_relative './sms_machine.rb'

#include SmsMachine

get '/' do
  'Sinatra has taken the stage.'

end

get '/send' do
  SmsFactory.send_sms(ENV['MY_CELL_PHONE_NUMBER'],ENV['TWILIO_PHONE_NUMBER'],"This is a test of a text!")
end

post '/sms' do

  @number = params['From']
  @body = params['Body']

  #is a new user?
  if User.exists?(:number => @number)
    puts "this number exists!!"
  else
    @user = User.create(number: @number)
    if @user.save
      puts "save complete"
    else
      puts "error"
    end
  end

  #stop automatically unsubscribes (how do we flag them in the database?)


  #if not a new user then create a new user
  # @user = User.create(number: @number)
  #
  # if @user.save
  #     puts 'success'
  # else
  #     puts 'There was a problem'
  # end

  #SmsFactory.respond_sms("What you sent me was: "+body)
end
