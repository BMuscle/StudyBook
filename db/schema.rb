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

ActiveRecord::Schema.define(version: 2020_10_30_145722) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgroonga"
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "my_list_notes", force: :cascade do |t|
    t.bigint "my_list_id", null: false
    t.bigint "note_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["my_list_id", "note_id"], name: "index_my_list_notes_on_my_list_id_and_note_id", unique: true
    t.index ["my_list_id"], name: "index_my_list_notes_on_my_list_id"
    t.index ["note_id"], name: "index_my_list_notes_on_note_id"
  end

  create_table "my_lists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.string "title", null: false
    t.text "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_my_lists_on_category_id"
    t.index ["id", "title", "description"], name: "index_full_text_my_lists", opclass: { title: :pgroonga_varchar_full_text_search_ops }, using: :pgroonga
    t.index ["user_id"], name: "index_my_lists_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.string "text", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_subscribe_my_lists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "my_list_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["my_list_id"], name: "index_user_subscribe_my_lists_on_my_list_id"
    t.index ["user_id", "my_list_id"], name: "index_user_subscribe_my_lists_on_user_id_and_my_list_id", unique: true
    t.index ["user_id"], name: "index_user_subscribe_my_lists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.string "nickname", limit: 30, null: false
    t.date "birthdate", null: false
    t.boolean "admin", default: false, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "my_list_notes", "my_lists"
  add_foreign_key "my_list_notes", "notes"
  add_foreign_key "my_lists", "categories"
  add_foreign_key "my_lists", "users"
  add_foreign_key "notes", "users"
  add_foreign_key "user_subscribe_my_lists", "my_lists"
  add_foreign_key "user_subscribe_my_lists", "users"
end
