class CreateQuestionsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :question, :null => false
      t.string :answer, :null => false #T or F
      t.string :answer_description
      t.string :more_info
      t.references :topic
    end
  end
end
