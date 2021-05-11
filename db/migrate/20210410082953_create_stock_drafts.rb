class CreateStockDrafts < ActiveRecord::Migration[6.1]
  def change
    create_table :stock_drafts do |t|
      t.string :round_id
      t.integer :user_id
      t.datetime :position_entry_time
      t.string :symbol
      t.decimal :position_size, precision: 8, scale: 2
      t.decimal :per_unit_entry_cost, precision: 8, scale: 2

      t.timestamps
    end
    add_index :stock_drafts, [:round_id, :symbol], unique: true
    add_index :stock_drafts, :user_id
  end
end
