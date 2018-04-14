require 'bundler'
Bundler.require()
require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './lib/constants'
require 'envyable'
Envyable.load('./config/env.yml', 'development')
require_relative './app/models/user.rb'
require_relative './app/models/topic.rb'
require_relative './app/models/question.rb'
require_relative './app/models/quiz_relationship.rb'
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
  @body = params['Body'].downcase.rstrip

  # Create user if not in database.
  if User.exists?(:number => @number)
    # Recall user
    @user = User.where(:number => @number).first
    if (@body =~ /^\w+$/) && (@body === "stop")
      #update boolean flag to stop
      @user.update!(:stop => true)
    elsif (@body =~ /^\w+$/) && (@body === "start")
      #they are back so let's take the flag off
      @user.update!(:stop => false)
    end
  else
    @user = User.create(number: @number)
    if @user.save
      puts "save complete"
      # Welcome user
      SmsFactory.send_sms(@user.number, WELCOME)
    else
      puts "error"
    end
  end

  # Listen, is it a topic keyword or action word?
  if (@body =~ /^\w+$/) && (!@user.stop)
    if Topic.pluck(:keyword).map(&:downcase).include?(@body)
      # This is a new topic
      # Return the first question
      @topic_id = Topic.find_by(:keyword => @body.downcase).id
      @first_question = Question.where(:topic_id => @topic_id).first
      # Ask the first question
      SmsFactory.send_sms(@number, @first_question.question)
      # Update user journey
    elsif ANSWER_KEYS.include?(@body)
      # This is an answer to a question
      @answer_to_question = ""
      puts "Answer response"
      SmsFactory.send_sms(@number, "ANSWER")
    elsif ACTION_KEYS.include?(@body)
      # This is an action
      puts "Action response"
      @action_output = "\n"
      if @body === 'list'
        Topic.all.each do |t|
          @action_output = @action_output.concat("Keyword: #{t.keyword.upcase}\n(#{t.description})\n")
        end
      end
      SmsFactory.send_sms(@number, @action_output)
    elsif @body === 'start'
      SmsFactory.send_sms(@number, WELCOME_BACK)
    else
      # I don't understand - send error message
      puts "Error response"
      SmsFactory.send_sms(@number, ERROR_RESPONSE)
    end
  else
    # I don't understand - send error message
    puts "Error response"
    SmsFactory.send_sms(@number, ERROR_TOO_MANY_WORDS) unless @user.stop
  end


end
