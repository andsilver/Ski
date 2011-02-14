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

ActiveRecord::Schema.define(:version => 20110214151208) do

  create_table "countries", :force => true do |t|
    t.string   "name",               :default => "",    :null => false
    t.string   "iso_3166_1_alpha_2", :default => "",    :null => false
    t.boolean  "valid_for_resorts",  :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries", ["valid_for_resorts"], :name => "index_countries_on_valid_for_resorts"

  create_table "images", :force => true do |t|
    t.integer  "user_id"
    t.string   "filename",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", :force => true do |t|
    t.integer  "user_id",                           :null => false
    t.integer  "resort_id",                         :null => false
    t.string   "title",             :default => "", :null => false
    t.integer  "metres_from_lift",  :default => 0,  :null => false
    t.integer  "sleeps",            :default => 0,  :null => false
    t.integer  "weekly_rent_price", :default => 0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "properties", ["resort_id"], :name => "index_properties_on_resort_id"
  add_index "properties", ["user_id"], :name => "index_properties_on_user_id"

  create_table "resorts", :force => true do |t|
    t.integer  "country_id", :default => 0,   :null => false
    t.string   "name",       :default => "0", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resorts", ["country_id"], :name => "index_resorts_on_country_id"

  create_table "users", :force => true do |t|
    t.string   "name",                                 :default => "",    :null => false
    t.string   "email",                                                   :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "interested_in_renting_out_properties", :default => false, :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"

end
