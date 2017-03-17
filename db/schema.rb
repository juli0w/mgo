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

ActiveRecord::Schema.define(version: 20170317173026) do

  create_table "album_pages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "albums", force: :cascade do |t|
    t.         "photos"
    t.integer  "company_id"
    t.string   "description"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["company_id"], name: "index_albums_on_company_id"
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "slug"
    t.string   "title"
    t.text     "content"
    t.string   "description"
    t.string   "cover"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["company_id"], name: "index_articles_on_company_id"
  end

  create_table "blank_pages", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blog_pages", force: :cascade do |t|
    t.integer  "max",        default: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "ancestor_id"
    t.string   "code"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "colors", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50, default: ""
    t.text     "comment"
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
    t.index ["commentable_type"], name: "index_comments_on_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id"
    t.string   "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "logotipo"
    t.         "photos"
    t.string   "slug"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "twitter"
    t.integer  "user_id"
    t.string   "code"
    t.string   "lat"
    t.string   "lng"
    t.boolean  "premium",     default: false
    t.string   "phone"
    t.string   "mail"
    t.integer  "city_id"
    t.integer  "uf_id"
    t.string   "address"
    t.index ["category_id"], name: "index_companies_on_category_id"
    t.index ["slug"], name: "index_companies_on_slug", unique: true
  end

  create_table "contact_pages", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "destination"
    t.integer  "company_id"
    t.boolean  "read",        default: false
  end

  create_table "fonts", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "pages", force: :cascade do |t|
    t.string   "pageable_type"
    t.integer  "pageable_id"
    t.string   "title"
    t.integer  "profile_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "description"
    t.string   "slug"
    t.integer  "index",         default: 1
    t.index ["profile_id"], name: "index_pages_on_profile_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "photo"
    t.string   "description"
    t.integer  "album_page_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["album_page_id"], name: "index_photos_on_album_page_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "company_id"
    t.text     "institutional"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "primary_color"
    t.string   "detail_color"
    t.string   "link_color"
    t.string   "text_color"
    t.string   "logo_color"
    t.string   "description_color"
    t.string   "cover"
    t.string   "layout",            default: "default"
    t.integer  "font_id"
    t.index ["company_id"], name: "index_profiles_on_company_id"
    t.index ["font_id"], name: "index_profiles_on_font_id"
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

  create_table "sample_templates", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "subscribes", force: :cascade do |t|
    t.string   "phone"
    t.string   "plan"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "company_id"
    t.integer  "state"
    t.datetime "paid_at"
    t.decimal  "price"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "templates", force: :cascade do |t|
    t.integer  "profile_id"
    t.integer  "primary_color_id"
    t.integer  "detail_color_id"
    t.integer  "link_color_id"
    t.integer  "text_color_id"
    t.integer  "logo_color_id"
    t.integer  "description_color_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "sample_template_id"
    t.index ["profile_id"], name: "index_templates_on_profile_id"
    t.index ["sample_template_id"], name: "index_templates_on_sample_template_id"
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
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.string   "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
