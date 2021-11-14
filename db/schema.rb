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

ActiveRecord::Schema.define(version: 2021_11_13_162855) do

  create_table "grudges", force: :cascade do |t|
    t.string "name"
    t.integer "points"
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "user1_id", null: false
    t.integer "user2_id", null: false
    t.string "relation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user1_id"], name: "index_relationships_on_user1_id"
    t.index ["user2_id"], name: "index_relationships_on_user2_id"
  end

  create_table "user_grudges", force: :cascade do |t|
    t.integer "guilty_id", null: false
    t.integer "offended_id", null: false
    t.integer "grudge_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["grudge_id"], name: "index_user_grudges_on_grudge_id"
    t.index ["guilty_id"], name: "index_user_grudges_on_guilty_id"
    t.index ["offended_id"], name: "index_user_grudges_on_offended_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "relationships", "users", column: "user1_id"
  add_foreign_key "relationships", "users", column: "user2_id"
  add_foreign_key "user_grudges", "grudges"
  add_foreign_key "user_grudges", "users", column: "guilty_id"
  add_foreign_key "user_grudges", "users", column: "offended_id"
end
