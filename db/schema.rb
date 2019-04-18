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

ActiveRecord::Schema.define(version: 2019_04_18_181655) do

  create_table "adverts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "months", default: 3, null: false
    t.datetime "starts_at"
    t.datetime "expires_at"
    t.boolean "moderated", default: false, null: false
    t.boolean "paused", default: false, null: false
    t.integer "views", default: 0, null: false
    t.integer "banner_advert_id"
    t.integer "directory_advert_id"
    t.integer "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "window_spot", default: false, null: false
    t.integer "order_id"
    t.index ["banner_advert_id"], name: "index_adverts_on_banner_advert_id"
    t.index ["directory_advert_id"], name: "index_adverts_on_directory_advert_id"
    t.index ["order_id"], name: "index_adverts_on_order_id"
    t.index ["property_id"], name: "index_adverts_on_property_id"
    t.index ["user_id"], name: "index_adverts_on_user_id"
  end

  create_table "airport_distances", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "resort_id", null: false
    t.integer "airport_id", null: false
    t.integer "distance_km", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["resort_id"], name: "index_airport_distances_on_resort_id"
  end

  create_table "airport_transfers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "airport_id", null: false
    t.integer "resort_id", null: false
    t.integer "user_id", null: false
    t.boolean "publicly_visible", default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["airport_id"], name: "index_airport_transfers_on_airport_id"
    t.index ["resort_id"], name: "index_airport_transfers_on_resort_id"
    t.index ["user_id"], name: "index_airport_transfers_on_user_id"
  end

  create_table "airports", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "code", default: "", null: false
    t.integer "country_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "alt_attributes", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "path", null: false
    t.string "alt_text", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["path"], name: "index_alt_attributes_on_path"
  end

  create_table "amenities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "amenities_properties", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "amenity_id"
    t.bigint "property_id"
    t.index ["amenity_id"], name: "index_amenities_properties_on_amenity_id"
    t.index ["property_id"], name: "index_amenities_properties_on_property_id"
  end

  create_table "availabilities", primary_key: ["start_date", "property_id"], options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "property_id", null: false
    t.date "start_date", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "availability", limit: 1, null: false
    t.boolean "check_in", null: false
    t.boolean "check_out", null: false
    t.index ["property_id"], name: "index_availabilities_on_property_id"
    t.index ["start_date", "property_id"], name: "index_availabilities_on_start_date_and_property_id"
    t.index ["start_date"], name: "index_availabilities_on_start_date"
  end

  create_table "banner_adverts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "resort_id", null: false
    t.integer "image_id"
    t.string "url", null: false
    t.integer "width", default: 0, null: false
    t.integer "height", default: 0, null: false
    t.integer "clicks", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["resort_id"], name: "index_banner_adverts_on_resort_id"
    t.index ["user_id"], name: "index_banner_adverts_on_user_id"
  end

  create_table "buying_guides", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "country_id", null: false
    t.text "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["country_id"], name: "index_buying_guides_on_country_id"
  end

  create_table "carousel_slides", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "position", null: false
    t.string "image_url", null: false
    t.string "caption", null: false
    t.string "link", null: false
    t.datetime "active_from", null: false
    t.datetime "active_until", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "alt"
  end

  create_table "categories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "iso_3166_1_alpha_2", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "info"
    t.boolean "popular_billing_country", default: false, null: false
    t.boolean "in_eu", default: false, null: false
    t.integer "image_id"
    t.integer "property_count", default: 0, null: false
    t.string "slug", null: false
    t.index ["slug"], name: "index_countries_on_slug"
  end

  create_table "coupons", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "code"
    t.integer "number_of_adverts"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "percentage_off", default: 100, null: false
    t.date "expires_on"
  end

  create_table "currencies", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "unit", default: "", null: false
    t.boolean "pre", default: true, null: false
    t.string "code", default: "", null: false
    t.decimal "in_euros", precision: 6, scale: 4, default: "1.0", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "directory_adverts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "business_address", null: false
    t.string "postcode", default: "", null: false
    t.string "opening_hours", default: "", null: false
    t.integer "resort_id"
    t.string "phone", default: "", null: false
    t.integer "image_id"
    t.string "url", default: "", null: false
    t.string "strapline", default: "", null: false
    t.text "description"
    t.integer "width", default: 0, null: false
    t.integer "height", default: 0, null: false
    t.string "business_name", default: "", null: false
    t.index ["resort_id"], name: "index_directory_adverts_on_resort_id"
    t.index ["user_id"], name: "index_directory_adverts_on_user_id"
  end

  create_table "enquiries", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "property_id"
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.date "date_of_arrival"
    t.date "date_of_departure"
    t.text "comments"
    t.boolean "contact_me", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "number_of_adults", default: 0, null: false
    t.integer "number_of_children", default: 0, null: false
    t.integer "number_of_infants", default: 0, null: false
    t.boolean "permission_to_contact", default: false, null: false
  end

  create_table "footers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_footers_on_name"
  end

  create_table "holiday_type_brochures", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "brochurable_id"
    t.integer "holiday_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "brochurable_type"
    t.index ["brochurable_id"], name: "index_holiday_type_brochures_on_brochurable_id"
    t.index ["holiday_type_id"], name: "index_holiday_type_brochures_on_holiday_type_id"
  end

  create_table "holiday_types", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "visible_on_menu", default: true, null: false
    t.text "sidebar_html"
    t.text "mega_menu_html"
  end

  create_table "images", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.string "filename", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "property_id"
    t.text "source_url"
    t.index ["property_id"], name: "index_images_on_property_id"
  end

  create_table "interhome_accommodations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.string "country", null: false
    t.string "region", null: false
    t.string "place", null: false
    t.string "zip", null: false
    t.string "accommodation_type", null: false
    t.string "details", null: false
    t.integer "quality", null: false
    t.integer "brand", null: false
    t.integer "pax", null: false
    t.integer "sqm", null: false
    t.integer "floor", null: false
    t.integer "rooms", null: false
    t.integer "bedrooms", null: false
    t.integer "toilets", null: false
    t.integer "bathrooms", null: false
    t.string "geodata_lat", null: false
    t.string "geodata_lng", null: false
    t.text "features"
    t.string "themes", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "permalink"
    t.index ["code"], name: "index_interhome_accommodations_on_code"
    t.index ["permalink"], name: "index_interhome_accommodations_on_permalink"
  end

  create_table "interhome_inside_descriptions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "accommodation_code", null: false
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["accommodation_code"], name: "index_interhome_inside_descriptions_on_accommodation_code"
  end

  create_table "interhome_outside_descriptions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "accommodation_code", null: false
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["accommodation_code"], name: "index_interhome_outside_descriptions_on_accommodation_code"
  end

  create_table "interhome_pictures", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "interhome_accommodation_id", null: false
    t.string "picture_type", null: false
    t.string "season", null: false
    t.string "url", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["interhome_accommodation_id"], name: "index_interhome_pictures_on_interhome_accommodation_id"
  end

  create_table "interhome_place_resorts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "resort_id", null: false
    t.string "interhome_place_code", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["resort_id"], name: "index_interhome_place_resorts_on_resort_id"
  end

  create_table "interhome_places", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.string "full_name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code"], name: "index_interhome_places_on_code"
  end

  create_table "interhome_prices", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "accommodation_code", null: false
    t.integer "days", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.integer "rental_price", null: false
    t.integer "min_rental_price", null: false
    t.integer "max_rental_price", null: false
    t.string "special_offer_code"
    t.integer "special_offer_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "regular_price", default: 0, null: false
    t.index ["accommodation_code"], name: "index_interhome_prices_on_accommodation_code"
  end

  create_table "interhome_vacancies", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "interhome_accommodation_id", null: false
    t.string "accommodation_code", null: false
    t.date "startday"
    t.text "availability"
    t.text "changeover"
    t.text "minstay"
    t.text "flexbooking"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["accommodation_code"], name: "index_interhome_vacancies_on_accommodation_code"
    t.index ["interhome_accommodation_id"], name: "index_interhome_vacancies_on_interhome_accommodation_id"
  end

  create_table "order_lines", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "order_id", null: false
    t.string "description", null: false
    t.integer "amount", null: false
    t.integer "advert_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "coupon_id"
    t.integer "country_id"
    t.integer "resort_id"
    t.integer "windows", default: 0, null: false
    t.index ["advert_id"], name: "index_order_lines_on_advert_id"
    t.index ["country_id"], name: "index_order_lines_on_country_id"
    t.index ["coupon_id"], name: "index_order_lines_on_coupon_id"
    t.index ["order_id"], name: "index_order_lines_on_order_id"
    t.index ["resort_id"], name: "index_order_lines_on_resort_id"
  end

  create_table "orders", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.string "order_number", null: false
    t.string "email", null: false
    t.integer "status", null: false
    t.string "name", null: false
    t.string "address", null: false
    t.integer "country_id", null: false
    t.string "phone", null: false
    t.integer "total", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "postcode", default: "", null: false
    t.boolean "pay_monthly", default: false
    t.integer "first_payment", default: 0
    t.integer "subsequent_payments", default: 0
    t.integer "tax_amount", default: 0, null: false
    t.string "customer_vat_number", default: "", null: false
    t.string "tax_description", default: "VAT", null: false
    t.decimal "sterling_in_euros", precision: 6, scale: 4
    t.bigint "currency_id"
    t.index ["created_at"], name: "index_orders_on_created_at"
    t.index ["currency_id"], name: "index_orders_on_currency_id"
    t.index ["email"], name: "index_orders_on_email"
    t.index ["order_number"], name: "index_orders_on_order_number"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "pages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "path", null: false
    t.string "title", null: false
    t.string "description", default: "", null: false
    t.string "keywords", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "footer_id"
    t.text "content"
    t.boolean "visible", default: true, null: false
    t.string "sidebar_snippet_name"
    t.string "header_snippet_name"
    t.integer "region_id"
    t.integer "resort_id"
    t.index ["path"], name: "index_pages_on_path"
    t.index ["region_id"], name: "index_pages_on_region_id"
    t.index ["resort_id"], name: "index_pages_on_resort_id"
  end

  create_table "payments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "order_id"
    t.string "service_provider"
    t.string "installation_id"
    t.string "cart_id"
    t.string "description"
    t.string "amount"
    t.string "currency"
    t.boolean "test_mode"
    t.string "name"
    t.string "address"
    t.string "postcode"
    t.string "country"
    t.string "telephone"
    t.string "fax"
    t.string "email"
    t.string "transaction_id"
    t.string "transaction_status"
    t.string "transaction_time"
    t.text "raw_auth_message"
    t.boolean "accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "futurepay_id", default: "", null: false
    t.index ["created_at"], name: "index_payments_on_created_at"
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "properties", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "resort_id", null: false
    t.string "name", default: "", null: false
    t.string "strapline", default: "", null: false
    t.integer "sleeping_capacity", default: 0, null: false
    t.integer "number_of_bedrooms", default: 0, null: false
    t.boolean "new_development", default: false, null: false
    t.integer "listing_type", default: 0, null: false
    t.integer "image_id"
    t.integer "weekly_rent_price", default: 0, null: false
    t.boolean "fully_equipped_kitchen", default: false, null: false
    t.integer "tv", default: 0, null: false
    t.boolean "wifi", default: false, null: false
    t.boolean "disabled", default: false, null: false
    t.integer "parking", default: 0, null: false
    t.boolean "pets", default: false, null: false
    t.boolean "smoking", default: false, null: false
    t.integer "sale_price", default: 0, null: false
    t.boolean "garden", default: false, null: false
    t.integer "floor_area_metres_2", default: 0, null: false
    t.integer "plot_size_metres_2", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "description"
    t.integer "number_of_bathrooms", default: 0, null: false
    t.string "address", default: "", null: false
    t.string "postcode", default: "", null: false
    t.string "latitude", default: "", null: false
    t.string "longitude", default: "", null: false
    t.boolean "long_term_lets_available", default: false, null: false
    t.boolean "balcony", default: false, null: false
    t.boolean "mountain_views", default: false, null: false
    t.boolean "log_fire", default: false, null: false
    t.boolean "cave", default: false, null: false
    t.boolean "ski_in_ski_out", default: false, null: false
    t.boolean "hot_tub", default: false, null: false
    t.boolean "indoor_swimming_pool", default: false, null: false
    t.boolean "outdoor_swimming_pool", default: false, null: false
    t.boolean "sauna", default: false, null: false
    t.integer "distance_from_town_centre_m", default: 0, null: false
    t.integer "accommodation_type", default: 0, null: false
    t.integer "currency_id", default: 1, null: false
    t.integer "normalised_sale_price", default: 0, null: false
    t.integer "normalised_weekly_rent_price", default: 0, null: false
    t.boolean "children_welcome", default: false, null: false
    t.boolean "short_stays", default: false, null: false
    t.boolean "terrace", default: false, null: false
    t.integer "pericles_id"
    t.integer "board_basis", default: 0, null: false
    t.integer "interhome_accommodation_id"
    t.integer "country_id"
    t.boolean "publicly_visible", default: false, null: false
    t.boolean "late_availability", default: true
    t.integer "region_id"
    t.string "booking_url", default: "", null: false
    t.integer "flip_key_property_id"
    t.string "price_description", default: "", null: false
    t.string "layout"
    t.integer "trip_advisor_property_id"
    t.integer "min_stay", default: 3, null: false
    t.float "price_per_night", default: 0.0, null: false
    t.string "video"
    t.string "energy_performance"
    t.string "floorplan"
    t.index ["country_id"], name: "index_properties_on_country_id"
    t.index ["flip_key_property_id"], name: "index_properties_on_flip_key_property_id"
    t.index ["interhome_accommodation_id"], name: "index_properties_on_interhome_accommodation_id"
    t.index ["late_availability"], name: "index_properties_on_late_availability"
    t.index ["publicly_visible"], name: "index_properties_on_publicly_visible"
    t.index ["resort_id"], name: "index_properties_on_resort_id"
    t.index ["trip_advisor_property_id"], name: "index_properties_on_trip_advisor_property_id"
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "property_base_prices", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "number_of_months", default: 0, null: false
    t.integer "price", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "property_volume_discounts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "current_property_number", default: 0, null: false
    t.integer "discount_percentage", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "discount_amount", default: 0, null: false
  end

  create_table "regions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "country_id"
    t.string "name", null: false
    t.text "info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", null: false
    t.boolean "visible", default: true, null: false
    t.integer "property_count", default: 0, null: false
    t.boolean "featured", default: false
    t.string "image_url"
    t.string "strapline"
    t.string "logo_url"
    t.string "logo_alt"
    t.string "logo_title"
    t.integer "altitude_m"
    t.integer "top_lift_m"
    t.integer "piste_length_km"
    t.integer "lifts_n"
    t.integer "green"
    t.integer "blue"
    t.integer "red"
    t.integer "black"
    t.string "comment"
    t.index ["country_id"], name: "index_regions_on_country_id"
    t.index ["slug"], name: "index_regions_on_slug"
    t.index ["visible"], name: "index_regions_on_visible"
  end

  create_table "resorts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "country_id", default: 0, null: false
    t.string "name", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "info"
    t.integer "altitude_m"
    t.integer "top_lift_m"
    t.integer "piste_length_km"
    t.integer "black"
    t.integer "red"
    t.integer "blue"
    t.integer "green"
    t.integer "longest_run_km"
    t.integer "drags"
    t.integer "chair"
    t.integer "gondola"
    t.integer "cable_car"
    t.integer "funicular"
    t.integer "railways"
    t.string "slope_direction"
    t.integer "snowboard_parks"
    t.integer "cross_country_km"
    t.integer "mountain_restaurants"
    t.boolean "glacier_skiing"
    t.boolean "creche"
    t.boolean "babysitting_services"
    t.boolean "visible", default: false, null: false
    t.boolean "featured", default: false, null: false
    t.text "feature"
    t.text "introduction"
    t.string "season", default: "", null: false
    t.integer "beginner", default: 0, null: false
    t.integer "intermediate", default: 0, null: false
    t.integer "off_piste", default: 0, null: false
    t.integer "expert", default: 0, null: false
    t.boolean "heli_skiing"
    t.boolean "summer_skiing"
    t.integer "family", default: 0, null: false
    t.text "visiting"
    t.text "owning_a_property_in"
    t.text "living_in"
    t.text "insider_view"
    t.text "weather_code"
    t.string "apres_ski", default: "", null: false
    t.boolean "local_area", default: false, null: false
    t.integer "property_count", default: 0, null: false
    t.integer "for_rent_count", default: 0, null: false
    t.integer "for_sale_count", default: 0, null: false
    t.integer "new_development_count", default: 0, null: false
    t.text "gallery_content"
    t.text "piste_map_content"
    t.boolean "summer_only", default: false, null: false
    t.integer "directory_advert_count", default: 0, null: false
    t.integer "region_id"
    t.string "slug", null: false
    t.integer "ski_area_acre"
    t.string "image_url"
    t.string "strapline"
    t.string "comment"
    t.string "logo_url"
    t.string "logo_alt"
    t.string "logo_title"
    t.index ["country_id"], name: "index_resorts_on_country_id"
    t.index ["featured"], name: "index_resorts_on_featured"
    t.index ["region_id"], name: "index_resorts_on_region_id"
    t.index ["slug"], name: "index_resorts_on_slug"
    t.index ["visible"], name: "index_resorts_on_visible"
  end

  create_table "reviews", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "property_id", null: false
    t.integer "rating", null: false
    t.string "title", null: false
    t.text "content"
    t.string "author_name", null: false
    t.string "author_location", null: false
    t.date "visited_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_reviews_on_property_id"
  end

  create_table "roles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.boolean "select_on_signup"
    t.boolean "admin"
    t.boolean "flag_new_development"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "advertises_properties_for_rent", default: false, null: false
    t.boolean "advertises_generally", default: false, null: false
    t.boolean "has_business_details", default: false, null: false
    t.boolean "has_a_website", default: false, null: false
    t.boolean "new_development_by_default", default: false, null: false
    t.text "sales_pitch"
    t.boolean "advertises_properties_for_sale", default: false, null: false
    t.boolean "advertises_through_windows", default: false, null: false
  end

  create_table "snippets", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.text "snippet"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "locale", default: "en", null: false
    t.index ["name"], name: "index_snippets_on_name"
  end

  create_table "tracked_actions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "remote_ip", default: "", null: false
    t.integer "trackable_id", null: false
    t.string "trackable_type", null: false
    t.integer "action_type", null: false
    t.string "http_user_agent", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["created_at"], name: "index_tracked_actions_on_created_at"
    t.index ["trackable_id", "action_type"], name: "index_tracked_actions_on_trackable_id_and_action_type"
    t.index ["trackable_id"], name: "index_tracked_actions_on_trackable_id"
  end

  create_table "trip_advisor_calendar_entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "trip_advisor_property_id"
    t.string "status", null: false
    t.date "inclusive_start", null: false
    t.date "exclusive_end", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_advisor_property_id"], name: "index_trip_advisor_calendar_entries_on_trip_advisor_property_id"
  end

  create_table "trip_advisor_locations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "location_type", null: false
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "resort_id"
    t.index ["parent_id"], name: "index_trip_advisor_locations_on_parent_id"
    t.index ["resort_id"], name: "index_trip_advisor_locations_on_resort_id"
  end

  create_table "trip_advisor_properties", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "property_type"
    t.integer "bedrooms"
    t.integer "beds"
    t.integer "sleeps"
    t.integer "bathrooms"
    t.string "title"
    t.string "country"
    t.string "city"
    t.string "url"
    t.string "status"
    t.decimal "review_average", precision: 2, scale: 1
    t.boolean "show_pin", default: false, null: false
    t.string "lat_long"
    t.string "country_code"
    t.string "postal_code"
    t.string "search_url"
    t.boolean "can_accept_inquiry", default: false, null: false
    t.string "booking_option"
    t.integer "min_stay_high"
    t.integer "min_stay_low"
    t.integer "trip_advisor_location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "starting_price", null: false
    t.integer "currency_id", null: false
    t.text "description"
    t.index ["currency_id"], name: "index_trip_advisor_properties_on_currency_id"
    t.index ["trip_advisor_location_id"], name: "index_trip_advisor_properties_on_trip_advisor_location_id"
    t.index ["updated_at"], name: "index_trip_advisor_properties_on_updated_at"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password"
    t.string "salt"
    t.string "website", default: "", null: false
    t.text "description"
    t.string "billing_street", null: false
    t.string "billing_locality", default: "", null: false
    t.string "billing_city", null: false
    t.string "billing_county", default: "", null: false
    t.string "billing_postcode", default: "", null: false
    t.integer "billing_country_id"
    t.string "phone", default: "", null: false
    t.string "mobile", default: "", null: false
    t.string "business_name", default: "", null: false
    t.string "position", default: "", null: false
    t.boolean "terms_and_conditions", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "role_id", null: false
    t.integer "coupon_id"
    t.string "forgot_password_token", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.integer "image_id"
    t.string "google_web_property_id", default: "", null: false
    t.string "vat_number", default: "", null: false
    t.integer "vat_country_id"
    t.boolean "apply_price_override", default: false, null: false
    t.integer "price_override", default: 0, null: false
    t.text "enquiry_cc_emails"
    t.index ["email"], name: "index_users_on_email"
    t.index ["last_name"], name: "index_users_on_last_name"
  end

  create_table "websites", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.text "terms"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "privacy_policy"
    t.text "home_content"
    t.integer "directory_advert_price", default: 0, null: false
    t.text "start_page_content"
    t.string "worldpay_installation_id", default: "", null: false
    t.boolean "worldpay_active", default: false, null: false
    t.boolean "worldpay_test_mode", default: false, null: false
    t.boolean "skip_payment", default: false, null: false
    t.string "worldpay_payment_response_password", default: "", null: false
    t.text "contact_details"
    t.decimal "vat_rate", precision: 4, scale: 2, default: "20.0", null: false
    t.text "resources_banner_html"
    t.string "featured_properties_ids", default: "", null: false
    t.text "sidebar_html"
  end

  create_table "window_base_prices", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "quantity", default: 0, null: false
    t.integer "price", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
