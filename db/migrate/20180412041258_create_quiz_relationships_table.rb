class CreateQuizRelationshipsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :quiz_relationships do |t|
      t.references :topic
      t.references :question
    end
  end
end
