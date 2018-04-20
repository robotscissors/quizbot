class Calculations
  def self.overall_score(user)
    # calculate the overall score
    @current_place = Score.where(:user_id => user.id).last
    @points = Score.where(:user_id => user.id).sum(:point)
    @possible_points = Score.where(:user_id => user.id).count
    @percent_correct = (@points.to_f / @possible_points.to_f)*100.00.round(2)
    "Your score is: #{@points} out of #{@possible_points}. That's #{@percent_correct}% correct! "
  end

  def self.quiz_score(user,topic)
    @current_place = Score.where(:user_id => user.id).last
    @array_of_items = Question.select(:id).where(:topic_id => topic.topic_id)
    @points = Score.where(:user_id => user.id, :question_id => @array_of_items).sum(:point)
    "You got #{@points}/#{@array_of_items.length} on this quiz. "

  end

  def self.next_question(user)
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

end
