class InputValidator
  def self.is_single_word?(body)
    body.match(/^\w+$/) #is it a single word?
  end

  def self.is_it_a_keyword(body)
    Topic.pluck(:keyword).map(&:downcase).include?(body)
  end
end
