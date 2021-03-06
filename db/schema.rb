# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170515012826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "degrees", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string   "name",                             null: false
    t.integer  "active",               default: 1
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "category_id"
    t.integer  "origin_id"
    t.integer  "kind_id"
    t.string   "product_id"
    t.integer  "alcohol_tolerance_id"
    t.integer  "flocculation_id"
    t.float    "color"
    t.float    "ppg"
    t.float    "alpha"
  end

  create_table "inventories", force: :cascade do |t|
    t.integer  "user_id",                   null: false
    t.integer  "ingredient_id",             null: false
    t.float    "amount",                    null: false
    t.integer  "unit_id",                   null: false
    t.integer  "active",        default: 1
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "kinds", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "origins", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.integer  "recipe_id",              null: false
    t.integer  "rating",                 null: false
    t.text     "comment"
    t.integer  "active",     default: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.integer  "recipe_id",                 null: false
    t.integer  "ingredient_id",             null: false
    t.float    "amount"
    t.string   "unit_id"
    t.integer  "active",        default: 1
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "time"
    t.integer  "use_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.integer  "user_id",                      null: false
    t.string   "name",                         null: false
    t.text     "notes"
    t.integer  "active",           default: 1
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.float    "batch_size"
    t.float    "boil_size"
    t.integer  "boil_time"
    t.float    "original_gravity"
    t.float    "final_gravity"
    t.float    "boil_gravity"
    t.float    "ferment_temp"
    t.index ["name"], name: "index_recipes_on_name", unique: true, using: :btree
  end

  create_table "units", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",                               null: false
    t.string   "user_img"
    t.text     "bio"
    t.integer  "active",                 default: 1
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "uses", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
