class CreateUsersTable < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :number
      t.datetime :join_date, :null => false, :default => Time.now
      t.boolean :stop, :default => false
      t.datetime :updated_at, :null => false, :default => Time.now
    end
  end
end
