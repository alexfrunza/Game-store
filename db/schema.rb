# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_01_064818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "developers", force: :cascade do |t|
    t.string "name"
    t.text "about"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "franchises", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "game_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "game_types_games", id: false, force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "game_type_id", null: false
    t.index ["game_id", "game_type_id"], name: "index_game_types_games_on_game_id_and_game_type_id"
    t.index ["game_type_id", "game_id"], name: "index_game_types_games_on_game_type_id_and_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "title"
    t.text "about"
    t.integer "stock"
    t.string "release_date"
    t.bigint "developer_id", null: false
    t.bigint "franchise_id"
    t.bigint "platform_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "rarity_id", null: false
    t.index ["developer_id"], name: "index_games_on_developer_id"
    t.index ["franchise_id"], name: "index_games_on_franchise_id"
    t.index ["platform_id"], name: "index_games_on_platform_id"
    t.index ["rarity_id"], name: "index_games_on_rarity_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "user_id", null: false
    t.string "status"
    t.datetime "returned_time"
    t.datetime "return_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_orders_on_game_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rarities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "games", "developers"
  add_foreign_key "games", "franchises"
  add_foreign_key "games", "platforms"
  add_foreign_key "games", "rarities"
  add_foreign_key "orders", "games"
  add_foreign_key "orders", "users"
end
