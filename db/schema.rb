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

ActiveRecord::Schema[8.1].define(version: 2026_02_22_063737) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "reviews", force: :cascade do |t|
    t.integer "bread_compatibility"
    t.integer "category"
    t.text "comment"
    t.datetime "created_at", null: false
    t.integer "meat_taste"
    t.integer "meat_type"
    t.integer "overall_score", null: false
    t.integer "sauce_taste"
    t.integer "sauce_type"
    t.bigint "shop_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "value_for_money"
    t.integer "vegetable_amount"
    t.index ["shop_id"], name: "index_reviews_on_shop_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "address"
    t.string "area"
    t.datetime "created_at", null: false
    t.string "image_url1"
    t.string "image_url2"
    t.string "image_url3"
    t.float "lat"
    t.float "lng"
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["area"], name: "index_shops_on_area"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "reviews", "shops"
  add_foreign_key "reviews", "users"
end
