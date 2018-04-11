class CreateScoreTable < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.references :user, :null => false
      t.references :question, :null => false
      t.integer :point, :default => nil
    end
  end
end
