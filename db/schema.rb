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

ActiveRecord::Schema.define(version: 2021_03_24_202521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "congregations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "api_access"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "lat"
    t.float "lng"
  end

  create_table "dncs", force: :cascade do |t|
    t.string "address"
    t.bigint "territory_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date"
    t.index ["territory_id"], name: "index_dncs_on_territory_id"
  end

  create_table "external_contacts", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone"
    t.bigint "congregation_id", null: false
    t.float "lat"
    t.float "lng"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["congregation_id"], name: "index_external_contacts_on_congregation_id"
  end

  create_table "points", force: :cascade do |t|
    t.bigint "territory_id", null: false
    t.float "lat"
    t.float "lng"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["territory_id"], name: "index_points_on_territory_id"
  end

  create_table "territories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "congregation_id", null: false
    t.index ["congregation_id"], name: "index_territories_on_congregation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "congregation_id", null: false
    t.string "role"
    t.index ["congregation_id"], name: "index_users_on_congregation_id"
  end

  add_foreign_key "dncs", "territories"
  add_foreign_key "external_contacts", "congregations"
  add_foreign_key "points", "territories"
  add_foreign_key "territories", "congregations"
  add_foreign_key "users", "congregations"
end
