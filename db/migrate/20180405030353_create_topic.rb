class CreateTopic < ActiveRecord::Migration[5.1]
  def change
    create_table :topics do |t|
      t.string :keyword, :null => false
      t.string :description, :null => false
    end
  end
end
