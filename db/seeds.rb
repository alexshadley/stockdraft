# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Round.create([
  { round_id: 'test', display_name: 'Test Round', creation_time: Time.now.getutc}
])

for i in [1, 2, 3]
  User.create({
    round_id: 'test',
    user_id: i,
    display_name: i.to_s
  })
end

StockDraft.create({
  round_id: 'test',
  user_id: 1,
  position_entry_time: Time.now.getutc,
  symbol: 'GOOG',
  position_size: 10,
  per_unit_entry_cost: 20
})
StockDraft.create({
  round_id: 'test',
  user_id: 1,
  position_entry_time: Time.now.getutc,
  symbol: 'TSLA',
  position_size: 10,
  per_unit_entry_cost: 20
})
StockDraft.create({
  round_id: 'test',
  user_id: 2,
  position_entry_time: Time.now.getutc,
  symbol: 'TSLA',
  position_size: 10,
  per_unit_entry_cost: 20
})
StockDraft.create({
  round_id: 'test',
  user_id: 2,
  position_entry_time: Time.now.getutc,
  symbol: 'GME',
  position_size: 10,
  per_unit_entry_cost: 20
})
StockDraft.create({
  round_id: 'test',
  user_id: 3,
  position_entry_time: Time.now.getutc,
  symbol: 'AAPL',
  position_size: 10,
  per_unit_entry_cost: 20
})
StockDraft.create({
  round_id: 'test',
  user_id: 3,
  position_entry_time: Time.now.getutc,
  symbol: 'MSFT',
  position_size: 10,
  per_unit_entry_cost: 20
})