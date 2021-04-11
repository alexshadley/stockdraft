class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.integer :user_id
      t.string :session_id
      t.string :round_id
      t.string :display_name

      t.timestamps
    end 
    # Below execute statements for auto increment functionality on the table
    execute "CREATE SEQUENCE users_user_id_seq START 1001"
    execute "ALTER TABLE users ALTER COLUMN user_id SET DEFAULT NEXTVAL('users_user_id_seq')"
    add_index :users, :user_id
    add_index :users, :session_id
    add_index :users, :round_id
  end
end
