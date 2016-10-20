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

ActiveRecord::Schema.define(version: 20161018211347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "news", force: :cascade do |t|
    t.string   "title"
    t.text     "excerpt"
    t.string   "address_url"
    t.string   "image"
    t.string   "image_alt"
    t.integer  "source_id"
    t.integer  "newsletter_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["newsletter_id"], name: "index_news_on_newsletter_id", using: :btree
    t.index ["source_id"], name: "index_news_on_source_id", using: :btree
  end

  create_table "newsletters", force: :cascade do |t|
    t.string   "title"
    t.date     "sent_at"
    t.text     "excerpt"
    t.string   "address_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "sources", force: :cascade do |t|
    t.string   "address_url"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "news", "newsletters"
  add_foreign_key "news", "sources"
end
