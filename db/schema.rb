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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140829013344) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "blocks", :force => true do |t|
    t.string   "label",      :limit => 20, :null => false
    t.text     "body"
    t.string   "image"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "blocks", ["image"], :name => "index_blocks_on_image"
  add_index "blocks", ["label"], :name => "index_blocks_on_label"

  create_table "events", :force => true do |t|
    t.string   "title",                                       :null => false
    t.string   "permalink",  :limit => 61,                    :null => false
    t.text     "body"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "days"
    t.boolean  "imported",                 :default => false
    t.string   "image"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "events", ["created_at"], :name => "index_events_on_created_at"
  add_index "events", ["image"], :name => "index_events_on_image"
  add_index "events", ["permalink"], :name => "index_events_on_permalink"
  add_index "events", ["starts_at"], :name => "index_events_on_starts_at"

  create_table "links", :force => true do |t|
    t.string   "url",         :null => false
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "links", ["created_at"], :name => "index_links_on_created_at"

  create_table "media", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "file"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "type"
  end

  add_index "media", ["file"], :name => "index_media_on_file"
  add_index "media", ["type"], :name => "index_media_on_type"

  create_table "posts", :force => true do |t|
    t.string   "title",                                       :null => false
    t.text     "body"
    t.string   "permalink",  :limit => 61,                    :null => false
    t.boolean  "imported",                 :default => false
    t.string   "image"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "posts", ["created_at"], :name => "index_posts_on_created_at"
  add_index "posts", ["image"], :name => "index_posts_on_image"
  add_index "posts", ["permalink"], :name => "index_posts_on_permalink"

  create_table "projects", :force => true do |t|
    t.string   "title",                                        :null => false
    t.string   "permalink",   :limit => 61,                    :null => false
    t.text     "body"
    t.datetime "happened_at"
    t.boolean  "imported",                  :default => false
    t.string   "image"
    t.string   "file"
    t.string   "file_title"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.boolean  "written",                   :default => false
  end

  add_index "projects", ["created_at"], :name => "index_projects_on_created_at"
  add_index "projects", ["file"], :name => "index_projects_on_file"
  add_index "projects", ["image"], :name => "index_projects_on_image"
  add_index "projects", ["imported"], :name => "index_projects_on_imported"
  add_index "projects", ["written"], :name => "index_projects_on_written"

end