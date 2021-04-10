class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.integer :user_id
      t.string :session_id
      t.string :round_id
      t.string :display_name

      t.timestamps
    end
    add_index :users, :user_id
    add_index :users, :session_id
    add_index :users, :round_id
  end
end
