class Question < ActiveRecord::Base
  belongs_to :topic

  def self.get_first_id(topic)
    self.where(:topic_id => topic.id).first.id
  end

  def self.get_question(position)
    self.where(:id => position)[0].detail
  end

  def self.get_answer(current_place)
    self.where(:id => current_place.question_id)[0].answer.downcase
  end


  def self.is_there_a_next_question?(user)
    # Used to find out if there is a next question
    @current_place = Score.where(:user_id => user.id).last
    @current_question_id = @current_place.question_id
    @current_topic = Question.where(:id => @current_question_id)[0].topic_id
    @question_array = Question.where(:topic_id => @current_topic)
    # how big is the array
    @questions_total = @question_array.length
    # where are you in the array
    @array_position = @question_array.index(@question_array.find { |x| x.id === @current_question_id})
    # advance one question
    @array_position += 1
    return true if @array_position <= @questions_total-1 # did they finish this category
    false
  end

  def self.repeat_question(user)
    @current_place = Score.current_place(user.id)
    if @current_place.point === nil
      @current_question_id = @current_place.question_id
      @question_string = self.where(:id => @current_question_id)[0].detail
      "The question is: #{@question_string}"
    else #they had already finished a question.
      self.next_question(user)
    end
  end

  def self.next_question(user)
    @user = user
    return "Oops, looks like you need to pick a new quiz. You finished the last question. Reply with LIST to get a listing of other quizzes. " unless Question.is_there_a_next_question?(user)
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
      @next_question_id = @question_array[@array_position].id
      Score.create!(user_id: @user.id, question_id: @next_question_id)
      # ask the question
      @question_string = Question.get_question(@next_question_id)
      "Your next question: #{@question_string}"
    end
  end

end
