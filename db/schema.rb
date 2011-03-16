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

ActiveRecord::Schema.define(:version => 20110315120823) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "resort_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string   "name",               :default => "", :null => false
    t.string   "iso_3166_1_alpha_2", :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "directory_adverts", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "category_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enquiries", :force => true do |t|
    t.integer  "user_id",                              :null => false
    t.integer  "property_id"
    t.string   "name",                                 :null => false
    t.string   "email",                                :null => false
    t.string   "phone",                                :null => false
    t.string   "postcode",                             :null => false
    t.date     "date_of_arrival"
    t.date     "date_of_departure"
    t.text     "comments",                             :null => false
    t.boolean  "contact_me",        :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.integer  "user_id"
    t.string   "filename",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", :force => true do |t|
    t.integer  "user_id",                                   :null => false
    t.integer  "resort_id",                                 :null => false
    t.string   "name",                   :default => "",    :null => false
    t.string   "strapline",              :default => "",    :null => false
    t.integer  "metres_from_lift",       :default => 0,     :null => false
    t.integer  "sleeping_capacity",      :default => 0,     :null => false
    t.integer  "number_of_bedrooms",     :default => 0,     :null => false
    t.boolean  "new_development",        :default => false, :null => false
    t.boolean  "for_sale",               :default => false, :null => false
    t.integer  "image_id"
    t.integer  "weekly_rent_price",      :default => 0,     :null => false
    t.boolean  "fully_equipped_kitchen", :default => false, :null => false
    t.boolean  "tv",                     :default => false, :null => false
    t.boolean  "wifi",                   :default => false, :null => false
    t.boolean  "disabled",               :default => false, :null => false
    t.boolean  "parking",                :default => false, :null => false
    t.boolean  "pets",                   :default => false, :null => false
    t.boolean  "smoking",                :default => false, :null => false
    t.integer  "sale_price",             :default => 0,     :null => false
    t.boolean  "garage",                 :default => false, :null => false
    t.boolean  "private_garden",         :default => false, :null => false
    t.integer  "floor_area_metres_2",    :default => 0,     :null => false
    t.integer  "plot_size_metres_2",     :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "properties", ["resort_id"], :name => "index_properties_on_resort_id"
  add_index "properties", ["user_id"], :name => "index_properties_on_user_id"

  create_table "resorts", :force => true do |t|
    t.integer  "country_id", :default => 0,  :null => false
    t.string   "name",       :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "info"
  end

  add_index "resorts", ["country_id"], :name => "index_resorts_on_country_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.boolean  "select_on_signup"
    t.boolean  "admin"
    t.boolean  "flag_new_development"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                                 :default => "",    :null => false
    t.string   "email",                                :default => "",    :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "website",                              :default => "",    :null => false
    t.text     "description",                                             :null => false
    t.string   "billing_street",                                          :null => false
    t.string   "billing_locality",                     :default => "",    :null => false
    t.string   "billing_city",                                            :null => false
    t.string   "billing_county",                       :default => "",    :null => false
    t.string   "billing_postcode",                     :default => "",    :null => false
    t.integer  "billing_country_id"
    t.string   "phone",                                :default => "",    :null => false
    t.string   "mobile",                               :default => "",    :null => false
    t.string   "business_name",                        :default => "",    :null => false
    t.string   "position",                             :default => "",    :null => false
    t.boolean  "terms_and_conditions",                                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "interested_in_renting_out_properties", :default => false, :null => false
    t.integer  "role_id",                                                 :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"

end
