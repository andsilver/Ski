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

ActiveRecord::Schema.define(:version => 20110527174259) do

  create_table "adverts", :force => true do |t|
    t.integer  "user_id",                                :null => false
    t.integer  "months",              :default => 3,     :null => false
    t.datetime "starts_at"
    t.datetime "expires_at"
    t.boolean  "moderated",           :default => false, :null => false
    t.boolean  "paused",              :default => false, :null => false
    t.integer  "views",               :default => 0,     :null => false
    t.integer  "banner_advert_id"
    t.integer  "directory_advert_id"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adverts", ["banner_advert_id"], :name => "index_adverts_on_banner_advert_id"
  add_index "adverts", ["directory_advert_id"], :name => "index_adverts_on_directory_advert_id"
  add_index "adverts", ["property_id"], :name => "index_adverts_on_property_id"
  add_index "adverts", ["user_id"], :name => "index_adverts_on_user_id"

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string   "name",               :default => "", :null => false
    t.string   "iso_3166_1_alpha_2", :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "info"
  end

  create_table "coupons", :force => true do |t|
    t.string   "code"
    t.integer  "free_adverts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", :force => true do |t|
    t.string   "name",                                     :default => "",   :null => false
    t.string   "unit",                                     :default => "",   :null => false
    t.boolean  "pre",                                      :default => true, :null => false
    t.string   "code",                                     :default => "",   :null => false
    t.decimal  "in_euros",   :precision => 6, :scale => 4, :default => 1.0,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "directory_adverts", :force => true do |t|
    t.integer  "user_id",                          :null => false
    t.integer  "category_id",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "business_address",                 :null => false
    t.string   "postcode",         :default => "", :null => false
    t.string   "opening_hours",    :default => "", :null => false
    t.integer  "resort_id"
  end

  add_index "directory_adverts", ["resort_id"], :name => "index_directory_adverts_on_resort_id"

  create_table "enquiries", :force => true do |t|
    t.integer  "user_id",                               :null => false
    t.integer  "property_id"
    t.string   "name",                                  :null => false
    t.string   "email",                                 :null => false
    t.string   "phone",                                 :null => false
    t.date     "date_of_arrival"
    t.date     "date_of_departure"
    t.text     "comments",                              :null => false
    t.boolean  "contact_me",         :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number_of_adults",   :default => 0,     :null => false
    t.integer  "number_of_children", :default => 0,     :null => false
    t.integer  "number_of_infants",  :default => 0,     :null => false
  end

  create_table "images", :force => true do |t|
    t.integer  "user_id"
    t.string   "filename",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "property_id"
  end

  add_index "images", ["property_id"], :name => "index_images_on_property_id"

  create_table "order_lines", :force => true do |t|
    t.integer  "order_id",    :null => false
    t.string   "description", :null => false
    t.integer  "amount",      :null => false
    t.integer  "advert_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "coupon_id"
    t.integer  "country_id"
    t.integer  "resort_id"
  end

  add_index "order_lines", ["advert_id"], :name => "index_order_lines_on_advert_id"
  add_index "order_lines", ["country_id"], :name => "index_order_lines_on_country_id"
  add_index "order_lines", ["coupon_id"], :name => "index_order_lines_on_coupon_id"
  add_index "order_lines", ["order_id"], :name => "index_order_lines_on_order_id"
  add_index "order_lines", ["resort_id"], :name => "index_order_lines_on_resort_id"

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.string   "order_number",                 :null => false
    t.string   "email",                        :null => false
    t.integer  "status",                       :null => false
    t.string   "name",                         :null => false
    t.string   "address",                      :null => false
    t.integer  "country_id",                   :null => false
    t.string   "phone",                        :null => false
    t.integer  "total",                        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "postcode",     :default => "", :null => false
  end

  add_index "orders", ["email"], :name => "index_orders_on_email"
  add_index "orders", ["order_number"], :name => "index_orders_on_order_number"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "payments", :force => true do |t|
    t.integer  "order_id"
    t.string   "service_provider"
    t.string   "installation_id"
    t.string   "cart_id"
    t.string   "description"
    t.string   "amount"
    t.string   "currency"
    t.boolean  "test_mode"
    t.string   "name"
    t.string   "address"
    t.string   "postcode"
    t.string   "country"
    t.string   "telephone"
    t.string   "fax"
    t.string   "email"
    t.string   "transaction_id"
    t.string   "transaction_status"
    t.string   "transaction_time"
    t.text     "raw_auth_message"
    t.boolean  "accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["created_at"], :name => "index_payments_on_created_at"
  add_index "payments", ["order_id"], :name => "index_payments_on_order_id"

  create_table "properties", :force => true do |t|
    t.integer  "user_id",                                         :null => false
    t.integer  "resort_id",                                       :null => false
    t.string   "name",                         :default => "",    :null => false
    t.string   "strapline",                    :default => "",    :null => false
    t.integer  "metres_from_lift",             :default => 0,     :null => false
    t.integer  "sleeping_capacity",            :default => 0,     :null => false
    t.integer  "number_of_bedrooms",           :default => 0,     :null => false
    t.boolean  "new_development",              :default => false, :null => false
    t.boolean  "for_sale",                     :default => false, :null => false
    t.integer  "image_id"
    t.integer  "weekly_rent_price",            :default => 0,     :null => false
    t.boolean  "fully_equipped_kitchen",       :default => false, :null => false
    t.integer  "tv",                           :default => 0,     :null => false
    t.boolean  "wifi",                         :default => false, :null => false
    t.boolean  "disabled",                     :default => false, :null => false
    t.integer  "parking",                      :default => 0,     :null => false
    t.boolean  "pets",                         :default => false, :null => false
    t.boolean  "smoking",                      :default => false, :null => false
    t.integer  "sale_price",                   :default => 0,     :null => false
    t.boolean  "garden",                       :default => false, :null => false
    t.integer  "floor_area_metres_2",          :default => 0,     :null => false
    t.integer  "plot_size_metres_2",           :default => 0,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "number_of_bathrooms",          :default => 0,     :null => false
    t.string   "address",                      :default => "",    :null => false
    t.string   "postcode",                     :default => "",    :null => false
    t.string   "latitude",                     :default => "",    :null => false
    t.string   "longitude",                    :default => "",    :null => false
    t.boolean  "long_term_lets_available",     :default => false, :null => false
    t.boolean  "balcony",                      :default => false, :null => false
    t.boolean  "mountain_views",               :default => false, :null => false
    t.boolean  "log_fire",                     :default => false, :null => false
    t.boolean  "cave",                         :default => false, :null => false
    t.boolean  "ski_in_ski_out",               :default => false, :null => false
    t.boolean  "hot_tub",                      :default => false, :null => false
    t.boolean  "indoor_swimming_pool",         :default => false, :null => false
    t.boolean  "outdoor_swimming_pool",        :default => false, :null => false
    t.boolean  "sauna",                        :default => false, :null => false
    t.integer  "distance_from_town_centre_m",  :default => 0,     :null => false
    t.integer  "accommodation_type",           :default => 0,     :null => false
    t.integer  "currency_id",                  :default => 1,     :null => false
    t.integer  "normalised_sale_price",        :default => 0,     :null => false
    t.integer  "normalised_weekly_rent_price", :default => 0,     :null => false
  end

  add_index "properties", ["resort_id"], :name => "index_properties_on_resort_id"
  add_index "properties", ["user_id"], :name => "index_properties_on_user_id"

  create_table "property_base_prices", :force => true do |t|
    t.integer  "number_of_months", :default => 0, :null => false
    t.integer  "price",            :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "property_volume_discounts", :force => true do |t|
    t.integer  "current_property_number", :default => 0, :null => false
    t.integer  "discount_percentage",     :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resorts", :force => true do |t|
    t.integer  "country_id",               :default => 0,     :null => false
    t.string   "name",                     :default => "",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "info"
    t.integer  "altitude_m"
    t.integer  "top_lift_m"
    t.integer  "ski_area_km"
    t.integer  "black"
    t.integer  "red"
    t.integer  "blue"
    t.integer  "green"
    t.integer  "longest_run_km"
    t.integer  "drags"
    t.integer  "chair"
    t.integer  "gondola"
    t.integer  "cable_car"
    t.integer  "funicular"
    t.integer  "railways"
    t.string   "slope_direction"
    t.integer  "snowboard_parks"
    t.integer  "cross_country_km"
    t.integer  "mountain_restaurants"
    t.boolean  "glacier_skiing"
    t.string   "nearest_airport"
    t.integer  "distance_from_airport_km"
    t.boolean  "lively_apres_ski"
    t.boolean  "good_for_families"
    t.boolean  "creche"
    t.boolean  "babysitting_services"
    t.boolean  "visible",                  :default => false, :null => false
    t.boolean  "featured",                 :default => false, :null => false
    t.text     "feature"
  end

  add_index "resorts", ["country_id"], :name => "index_resorts_on_country_id"
  add_index "resorts", ["featured"], :name => "index_resorts_on_featured"
  add_index "resorts", ["visible"], :name => "index_resorts_on_visible"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.boolean  "select_on_signup"
    t.boolean  "admin"
    t.boolean  "flag_new_development"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "advertises_properties",      :default => false, :null => false
    t.boolean  "advertises_generally",       :default => false, :null => false
    t.boolean  "has_business_details",       :default => false, :null => false
    t.boolean  "has_a_website",              :default => false, :null => false
    t.boolean  "new_development_by_default", :default => false, :null => false
    t.text     "sales_pitch"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                  :default => "", :null => false
    t.string   "email",                 :default => "", :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "website",               :default => "", :null => false
    t.text     "description",                           :null => false
    t.string   "billing_street",                        :null => false
    t.string   "billing_locality",      :default => "", :null => false
    t.string   "billing_city",                          :null => false
    t.string   "billing_county",        :default => "", :null => false
    t.string   "billing_postcode",      :default => "", :null => false
    t.integer  "billing_country_id"
    t.string   "phone",                 :default => "", :null => false
    t.string   "mobile",                :default => "", :null => false
    t.string   "business_name",         :default => "", :null => false
    t.string   "position",              :default => "", :null => false
    t.boolean  "terms_and_conditions",                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id",                               :null => false
    t.integer  "coupon_id"
    t.string   "forgot_password_token", :default => "", :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email"

  create_table "websites", :force => true do |t|
    t.text     "terms"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "privacy_policy"
    t.text     "home_content"
  end

end
