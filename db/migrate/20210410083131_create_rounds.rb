class CreateRounds < ActiveRecord::Migration[6.1]
  def change
    create_table :rounds do |t|
      t.string :round_id
      t.string :display_name
      t.datetime :creation_time
      t.datetime :draft_finish_time
      t.datetime :round_finish_time

      t.timestamps
    end
    add_index :rounds, :round_id
  end
end
