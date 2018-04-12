class QuizRelationship < ActiveRecord::Base

  # attr_accessor :question,:answer,:answer_description,:more_info,:topic_id

  belongs_to :topic
  belongs_to :question

  class Q
    def self.make(question,answer,answer_description,more_info,topic)

      @question = Question.create(
        question: question,
        answer: answer,
        answer_description: answer_description,
        more_info: more_info
      )
      @relationship = QuizRelationship.create(
        topic_id: topic.id,
        question_id: @question.id
      )
    end
  end

  # def make(question,answer,answer_description,more_info,topic_id)
  #   Question.create(
  #     question: question,
  #     answer: answer,
  #     answer_description: answer_description,
  #     more_info: more_info
  #   )
  # end

end
