class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  def self.overall_score(user)
    # calculate the overall score
    @current_place = Score.current_place(user.id)
    @points = Score.where(:user_id => user.id).sum(:point)
    @possible_points = Score.where(:user_id => user.id).where.not(:point => nil).count
    @percent_correct = ((@points.to_f / @possible_points.to_f)*100.00).round(2)
    "Your total score for all quizzes is: #{@points} out of #{@possible_points}. That's #{@percent_correct}% correct! "
  end

  def self.quiz_score(user,topic_id)
    @current_place = Score.current_place(user.id)
    @array_of_items = Question.select(:id).where(:topic_id => topic_id)
    @points = Score.where(:user_id => user.id, :question_id => @array_of_items).sum(:point)
    "You got #{@points}/#{@array_of_items.length} on this quiz. "
  end

  def self.current_place(user_id)
      self.where(:user_id => user_id).last
  end

  def self.played_before?(user_id)
      return true if Score.where(:user_id => user_id).count > 0
      false
  end
end
