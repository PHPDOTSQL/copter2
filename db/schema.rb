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

ActiveRecord::Schema.define(:version => 20130522193134) do

  create_table "powers", :force => true do |t|
    t.string   "name",                             :null => false
    t.integer  "attack",                           :null => false
    t.integer  "defense",                          :null => false
    t.float    "e_attack",                         :null => false
    t.float    "e_defense",                        :null => false
    t.integer  "base_cost",           :limit => 8
    t.integer  "upkeep",              :limit => 8
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles_users", :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "soldiers", :force => true do |t|
    t.string   "name",                             :null => false
    t.integer  "attack",                           :null => false
    t.integer  "defense",                          :null => false
    t.float    "e_attack",                         :null => false
    t.float    "e_defense",                        :null => false
    t.integer  "base_cost",           :limit => 8
    t.integer  "upkeep",              :limit => 8
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "users", :force => true do |t|
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

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "weapons", :force => true do |t|
    t.string   "name",                                                :null => false
    t.integer  "attack",                                              :null => false
    t.integer  "defense",                                             :null => false
    t.float    "e_attack",                                            :null => false
    t.float    "e_defense",                                           :null => false
    t.integer  "base_cost",           :limit => 8
    t.integer  "upkeep",              :limit => 8
    t.integer  "div_power"
    t.boolean  "forgeable",                        :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
  end

end