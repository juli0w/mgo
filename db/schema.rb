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

ActiveRecord::Schema.define(version: 20170214105913) do

  create_table "albums", force: :cascade do |t|
    t.         "photos"
    t.integer  "company_id"
    t.string   "description"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["company_id"], name: "index_albums_on_company_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "ancestor_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "logotipo"
    t.         "photos"
    t.string   "slug"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "twitter"
    t.integer  "user_id"
    t.index ["category_id"], name: "index_companies_on_category_id"
    t.index ["slug"], name: "index_companies_on_slug", unique: true
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "destination"
  end

  create_table "maps", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "lat"
    t.string   "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_maps_on_company_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "category_name"
    t.decimal  "price_from"
    t.decimal  "price"
    t.string   "thumbnail"
    t.string   "link"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "seller_thumbnail"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "photo"
    t.string   "description"
    t.integer  "album_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["album_id"], name: "index_photos_on_album_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "company_id"
    t.text     "institutional"
    t.string   "phone"
    t.string   "mail"
    t.string   "address"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "primary_color"
    t.string   "detail_color"
    t.string   "link_color"
    t.string   "text_color"
    t.string   "logo_color"
    t.string   "description_color"
    t.string   "cover"
    t.integer  "city_id"
    t.integer  "uf_id"
    t.index ["company_id"], name: "index_profiles_on_company_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "stars"
    t.text     "comment"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "email"
    t.index ["company_id"], name: "index_reviews_on_company_id"
  end

  create_table "subscribes", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "plan"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_taggings_on_company_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ufs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
