class CreateQuestionsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :detail, :null => false
      t.string :answer, :null => false #T or F
      t.string :answer_description
      t.string :more_info
      t.references :topic, foreign_key: true
    end
  end
end
