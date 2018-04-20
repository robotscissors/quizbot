class Administration
  def self.clean_up_old_attempts(user,topic)
    # if the user enters in the keyword again, we want to erase
    # what scores they currently have and start overall_score
    @array_of_items = Question.select(:id).where(:topic_id => topic.id)
    Score.where(:question_id => @array_of_items, :user_id => user.id).destroy_all
  end

  def self.get_question(position)
    Question.where(:id => position)[0].detail
  end

  def self.next_question(user)
    @user = user
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
      @question_string = Administration.get_question(@next_question_id)
      "Your next question: #{@question_string}"
    end
  end


end
