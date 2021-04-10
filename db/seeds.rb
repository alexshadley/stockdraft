# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

HistoricalPrice.create([

])

Round.create([
  { round_id: 'test', display_name: 'Test Round', creation_time: Time.now.getutc}
])

i = 0
for ticker in ["AAPL", "TSLA", "GOOG"]
  StockDraft.create({
    round_id: 'test',
    user_id: i,
    position_entry_time: Time.now.getutc,
    symbol: ticker,
    position_size: 10,
    per_unit_entry_cost: 20
  })
  i += 1
end