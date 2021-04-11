# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_10_083131) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "historical_prices", force: :cascade do |t|
    t.string "symbol"
    t.datetime "time"
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["symbol"], name: "index_historical_prices_on_symbol"
  end

  create_table "rounds", force: :cascade do |t|
    t.string "round_id"
    t.string "display_name"
    t.datetime "creation_time"
    t.datetime "draft_finish_time"
    t.datetime "round_finish_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["round_id"], name: "index_rounds_on_round_id"
  end

  create_table "stock_drafts", force: :cascade do |t|
    t.string "round_id"
    t.integer "user_id"
    t.datetime "position_entry_time"
    t.string "symbol"
    t.decimal "position_size", precision: 8, scale: 2
    t.decimal "per_unit_entry_cost", precision: 8, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["round_id"], name: "index_stock_drafts_on_round_id"
    t.index ["user_id"], name: "index_stock_drafts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.serial "user_id"
    t.string "session_id"
    t.string "round_id"
    t.string "display_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["round_id"], name: "index_users_on_round_id"
    t.index ["session_id"], name: "index_users_on_session_id"
    t.index ["user_id"], name: "index_users_on_user_id"
  end

end
