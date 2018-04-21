class Administration
  def self.clean_up_old_attempts(user,topic)
    # if the user enters in the keyword again, we want to erase
    # what scores they currently have and start over
    @array_of_items = Question.select(:id).where(:topic_id => topic.id)
    Score.where(:question_id => @array_of_items, :user_id => user.id).destroy_all
  end

  

end
