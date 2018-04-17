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
require_relative './app/models/score.rb'
require_relative './sms_machine.rb'
require_relative './calculations.rb'
require_relative './administration.rb'

#include SmsMachine

get '/' do
  'Sinatra has taken the stage.'

end

get '/send' do
  SmsFactory.send_sms(ENV['MY_CELL_PHONE_NUMBER'],ENV['TWILIO_PHONE_NUMBER'],"This is a test of a text!")
end

post '/sms' do

  @number = params['From']
  @body = params['Body'].downcase.rstrip.lstrip

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
# ---------------------------------------------------

  # Listen, is it a topic keyword or action word?
  if (@body =~ /^\w+$/) && (!@user.stop)
    if Topic.pluck(:keyword).map(&:downcase).include?(@body)
      # This is a new topic
      # Return the first question
      @topic = Topic.find_by(:keyword => @body.downcase)
      #perform cleanup if necessary
      Administration.clean_up_old_attempts(@user,@topic)

      @first_question_id = Question.where(:topic_id => @topic.id).first.id
      # Ask the first question
      @question_string = Question.where(:id => @first_question_id)[0].detail
      @message = "#{@topic.description} Your first question: #{@question_string}"


      SmsFactory.send_sms(@number, @message)
      # insert user journey into
      Score.create!(user_id: @user.id, question_id: @first_question_id)

    elsif ANSWER_KEYS.include?(@body)
      # Find out where the user is on the journey
      @current_place = Score.where(:user_id => @user.id).last
      @current_topic = Question.where(:id => @current_place.question_id)
      puts "Answer to current question: #{@current_place.question_id}"
      #if point is nil that means they are answering this question (sychronous)
      if @current_place.point === nil
        puts "The question is: #{Question.where(:id => @current_place.question_id)[0].detail}"
        if Question.where(:id => @current_place.question_id)[0].answer.downcase === @body
          # correct: update the score table with a point
          Score.update(@current_place.id, :point => 1)
          @answer = "CORRECT! "
        else
          # wrong: update the score table with zero
          Score.update(@current_place.id, :point => 0)
          @answer = "Sorry, that's incorrect. "
        end
        # This is an answer to a question
        @answer = @answer.concat(Question.where(:id => @current_place.question_id)[0].answer_description)
        SmsFactory.send_sms(@number, @answer)
        #instructions for next question
        if Calculations.next_question(@user)
          @next_instruction = NEXT_QUESTION
        else
          @next_instruction = "You did it! #{Calculations.quiz_score(@user, @current_topic[0])}"
          @next_instruction = @next_instruction.concat(Calculations.overall_score(@user))
          @next_instruction = @next_instruction.concat("To see a list of quizzes reply with the keyword LIST.")
        end
        SmsFactory.send_sms(@number, @next_instruction)
      end
    elsif ACTION_KEYS.include?(@body)
      # This is an action
      @action_output = "\n"
      case @body
      when "n" # NEXT_QUESTION
        @current_place = Score.where(:user_id => @user.id).last
        @current_question_id = @current_place.question_id
        @current_topic = Question.where(:id => @current_question_id)[0].topic_id
        @question_array = Question.where(:topic_id => @current_topic)
        # how big is the array
        @questions_total = @question_array.length
        # where are you in the array
        @array_position = @question_array.index(@question_array.find { |x| x.id === @current_question_id})
        # advance one question
        @array_position += 1
        if @array_position <= @questions_total-1 # did they finish this category
          # update score database to advance to the next question
          Score.create!(user_id: @user.id, question_id: @question_array[@array_position].id)
          # ask the question
          @question_string = Question.where(:id => @array_position+1)[0].detail
          @action_output = "Your next question: #{@question_string}"
        end

      when 'list'
        Topic.all.each do |t|
          @action_output = @action_output.concat("Keyword: #{t.keyword.upcase}\n(#{t.description})\n")
        end
      when 'score'
        @action_output = @action_output.concat(Calculations.overall_score(@user))
      when 'start'
        @action_output =  WELCOME_BACK
      else
        # Error: I don't understand - send error message
        @action_output = ERROR_RESPONSE
      end
      SmsFactory.send_sms(@number, @action_output)

  else
    # Error: Too many words - I don't understand
    SmsFactory.send_sms(@number, ERROR_TOO_MANY_WORDS) unless @user.stop
  end
end

end
