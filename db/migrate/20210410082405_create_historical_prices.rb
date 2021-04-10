class CreateHistoricalPrices < ActiveRecord::Migration[6.1]
  def change
    create_table :historical_prices do |t|
      t.string :symbol
      t.datetime :time
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
    add_index :historical_prices, :symbol
  end
end
