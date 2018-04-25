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
require_relative './administration.rb'
require_relative './input_validator.rb'

get '/' do
  'QuizBot is on center stage with Sinatra.'
end

post '/sms' do
  @number = params['From']
  @body = params['Body'].downcase.rstrip.lstrip
  @user = User.check_if_user_new(@number,@body)
# ---------------------------------------------------
  # Listen, is it a topic keyword or action word?
  if (InputValidator.is_single_word?(@body)) && (!@user.stop)
    if InputValidator.is_it_a_keyword(@body)
      # Return the first question. If it is a topic then we
      # need the first quesiton of that topic.
      @topic = Topic.find_by(:keyword => @body.downcase)
      #perform cleanup if necessary erase any previous topic attempts
      Administration.clean_up_old_attempts(@user,@topic)
      #@first_question_id = Question.where(:topic_id => @topic.id).first.id
      @first_question_id = Question.get_first_id(@topic)
      # Ask the first question
      @question_string = Question.get_question(@first_question_id)
      @message = "#{@topic.description} Your first question: #{@question_string}"
      SmsFactory.send_sms(@number, @message)
      # insert user journey into the score table (point = nil by default)
      Score.create!(user_id: @user.id, question_id: @first_question_id)

    elsif ANSWER_KEYS.include?(@body)
      # Find out where the user is on the journey
      @current_place = Score.current_place(@user.id)
      @current_topic_id = Question.where(:id => @current_place.question_id)[0].topic_id
      #if point is nil that means they are answering this question (sychronous)
      if @current_place.point === nil
        if Question.get_answer(@current_place) === @body
          # correct: update the score table with a point
          Score.update(@current_place.id, :point => 1)
          @answer = CORRECT_ANSWER
        else
          # wrong: update the score table with zero
          Score.update(@current_place.id, :point => 0)
          @answer = WRONG_ANSWER
        end

        # This is an answer to a question
        @answer = "#{@answer} #{Question.where(:id => @current_place.question_id)[0].answer_description}"

        SmsFactory.send_sms(@number, @answer)
        #instructions for next question
        if Question.is_there_a_next_question?(@user)
          # is there more information?
          @next_instruction = ""
          @more_info = Question.where(:id => @current_place.question_id)[0].more_info
          @next_instruction = "Want more information: #{@more_info}. " if @more_info
          @next_instruction = @next_instruction.concat(NEXT_QUESTION)
        else
          @next_instruction = "You did it! #{Score.quiz_score(@user, @current_topic_id)}"
          @next_instruction = @next_instruction.concat(Score.overall_score(@user))
          @next_instruction = @next_instruction.concat("To see a list of quizzes reply with the keyword LIST.")
        end
        SmsFactory.send_sms(@number, @next_instruction)
      else
        # Hmmm I think you answered the question wrong.
      end
    elsif ACTION_KEYS.include?(@body)
      # This is an action
      @action_output = "\n"
      case @body
      when "y" # NEXT_QUESTION
        if Score.where(:user_id => @user.id).last.point != nil
          @action_output = Question.next_question(@user)
        else
          @action_output = Question.repeat_question(@user)
        end
      when 'list'
        @action_output = Topic.get_list_of_topics
      when 'score'
        @action_output = @action_output.concat(Score.overall_score(@user))
      when 'start'
        @action_output =  WELCOME_BACK
      when 'repeat'
        if Question.is_there_a_next_question?(@user)
          @action_output = Question.repeat_question(@user)
        else
          @action_output = "#{NO_NEXT_QUESTION} #{Topic.get_list_of_topics}"
        end
      else
        # Error: I don't understand - send error message
        @action_output = ERROR_RESPONSE
      end
      SmsFactory.send_sms(@number, @action_output)
    else
      # Let's check to see if they are a new user maybe they need help
      # getting started
      if Score.played_before?(@user.id)
        # Error: Too many words - I don't understand
        SmsFactory.send_sms(@number, ERROR_TOO_MANY_WORDS) unless @user.stop
      else
        # This user is new and didn't use a keyword.
        SmsFactory.send_sms(@number, NEW_USER_HELP) unless @user.stop
      end
    end
  end
end
