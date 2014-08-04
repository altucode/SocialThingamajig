# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140804164909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "circle_memberships", force: true do |t|
    t.integer "user_id"
    t.integer "circle_id"
    t.date    "created_at"
  end

  add_index "circle_memberships", ["user_id", "circle_id"], name: "index_circle_memberships_on_user_id_and_circle_id", unique: true, using: :btree

  create_table "circles", force: true do |t|
    t.string   "name",       null: false
    t.integer  "owner_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "circles", ["name", "owner_id"], name: "index_circles_on_name_and_owner_id", unique: true, using: :btree

  create_table "links", force: true do |t|
    t.string  "url",     null: false
    t.integer "post_id", null: false
  end

  add_index "links", ["url", "post_id"], name: "index_links_on_url_and_post_id", unique: true, using: :btree

  create_table "post_shares", force: true do |t|
    t.integer "post_id"
    t.integer "circle_id"
  end

  add_index "post_shares", ["circle_id"], name: "index_post_shares_on_circle_id", using: :btree
  add_index "post_shares", ["post_id"], name: "index_post_shares_on_post_id", using: :btree

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "session_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree

end
