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

ActiveRecord::Schema.define(:version => 20110204035316) do

  create_table "pastes", :force => true do |t|
    t.string   "guid",                          :null => false
    t.string   "filename"
    t.binary   "content"
    t.integer  "user_id",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pastes", ["guid"], :name => "index_pastes_on_guid"
  add_index "pastes", ["user_id"], :name => "index_pastes_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "github_account"
    t.string   "github_access_token"
    t.string   "access_token"
    t.string   "email"
    t.string   "name"
    t.string   "gravatar_id"
    t.string   "company"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
