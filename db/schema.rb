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

ActiveRecord::Schema.define(version: 20150223124607) do

  create_table "adverts", force: :cascade do |t|
    t.integer  "user_id",             limit: 4,                 null: false
    t.integer  "months",              limit: 4, default: 3,     null: false
    t.datetime "starts_at"
    t.datetime "expires_at"
    t.boolean  "moderated",           limit: 1, default: false, null: false
    t.boolean  "paused",              limit: 1, default: false, null: false
    t.integer  "views",               limit: 4, default: 0,     null: false
    t.integer  "banner_advert_id",    limit: 4
    t.integer  "directory_advert_id", limit: 4
    t.integer  "property_id",         limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.boolean  "window",              limit: 1, default: false, null: false
    t.integer  "order_id",            limit: 4
  end

  add_index "adverts", ["banner_advert_id"], name: "index_adverts_on_banner_advert_id", using: :btree
  add_index "adverts", ["directory_advert_id"], name: "index_adverts_on_directory_advert_id", using: :btree
  add_index "adverts", ["order_id"], name: "index_adverts_on_order_id", using: :btree
  add_index "adverts", ["property_id"], name: "index_adverts_on_property_id", using: :btree
  add_index "adverts", ["user_id"], name: "index_adverts_on_user_id", using: :btree

  create_table "airport_distances", force: :cascade do |t|
    t.integer  "resort_id",   limit: 4,             null: false
    t.integer  "airport_id",  limit: 4,             null: false
    t.integer  "distance_km", limit: 4, default: 0, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "airport_distances", ["resort_id"], name: "index_airport_distances_on_resort_id", using: :btree

  create_table "airport_transfers", force: :cascade do |t|
    t.integer  "airport_id",       limit: 4,                null: false
    t.integer  "resort_id",        limit: 4,                null: false
    t.integer  "user_id",          limit: 4,                null: false
    t.boolean  "publicly_visible", limit: 1, default: true, null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "airport_transfers", ["airport_id"], name: "index_airport_transfers_on_airport_id", using: :btree
  add_index "airport_transfers", ["resort_id"], name: "index_airport_transfers_on_resort_id", using: :btree
  add_index "airport_transfers", ["user_id"], name: "index_airport_transfers_on_user_id", using: :btree

  create_table "airports", force: :cascade do |t|
    t.string   "name",       limit: 255, default: "", null: false
    t.string   "code",       limit: 255, default: "", null: false
    t.integer  "country_id", limit: 4,                null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "alt_attributes", force: :cascade do |t|
    t.string   "path",       limit: 255,              null: false
    t.string   "alt_text",   limit: 255, default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "alt_attributes", ["path"], name: "index_alt_attributes_on_path", using: :btree

  create_table "availabilities", force: :cascade do |t|
    t.integer  "property_id",  limit: 4
    t.date     "start_date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "availability", limit: 1, null: false
  end

  add_index "availabilities", ["created_at"], name: "index_availabilities_on_created_at", using: :btree
  add_index "availabilities", ["property_id", "start_date"], name: "index_availabilities_on_property_id_and_start_date", using: :btree
  add_index "availabilities", ["property_id"], name: "index_availabilities_on_property_id", using: :btree
  add_index "availabilities", ["start_date"], name: "index_availabilities_on_start_date", using: :btree

  create_table "banner_adverts", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,               null: false
    t.integer  "resort_id",  limit: 4,               null: false
    t.integer  "image_id",   limit: 4
    t.string   "url",        limit: 255,             null: false
    t.integer  "width",      limit: 4,   default: 0, null: false
    t.integer  "height",     limit: 4,   default: 0, null: false
    t.integer  "clicks",     limit: 4,   default: 0, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "banner_adverts", ["resort_id"], name: "index_banner_adverts_on_resort_id", using: :btree
  add_index "banner_adverts", ["user_id"], name: "index_banner_adverts_on_user_id", using: :btree

  create_table "banner_prices", force: :cascade do |t|
    t.integer  "current_banner_number", limit: 4, default: 0, null: false
    t.integer  "price",                 limit: 4, default: 0, null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "buying_guides", force: :cascade do |t|
    t.integer  "country_id", limit: 4,     null: false
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "buying_guides", ["country_id"], name: "index_buying_guides_on_country_id", using: :btree

  create_table "carousel_slides", force: :cascade do |t|
    t.integer  "position",     limit: 4,   null: false
    t.string   "image_url",    limit: 255, null: false
    t.string   "caption",      limit: 255, null: false
    t.string   "link",         limit: 255, null: false
    t.datetime "active_from",              null: false
    t.datetime "active_until",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alt",          limit: 255
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name",                    limit: 255,   default: "",    null: false
    t.string   "iso_3166_1_alpha_2",      limit: 255,   default: "",    null: false
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.text     "info",                    limit: 65535
    t.boolean  "popular_billing_country", limit: 1,     default: false, null: false
    t.boolean  "in_eu",                   limit: 1,     default: false, null: false
    t.integer  "image_id",                limit: 4
    t.text     "banner_advert_html",      limit: 65535
    t.integer  "property_count",          limit: 4,     default: 0,     null: false
    t.string   "slug",                    limit: 255,                   null: false
  end

  add_index "countries", ["slug"], name: "index_countries_on_slug", using: :btree

  create_table "coupons", force: :cascade do |t|
    t.string   "code",              limit: 255
    t.integer  "number_of_adverts", limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "percentage_off",    limit: 4,   default: 100, null: false
    t.date     "expires_on"
  end

  create_table "currencies", force: :cascade do |t|
    t.string   "name",       limit: 255,                         default: "",   null: false
    t.string   "unit",       limit: 255,                         default: "",   null: false
    t.boolean  "pre",        limit: 1,                           default: true, null: false
    t.string   "code",       limit: 255,                         default: "",   null: false
    t.decimal  "in_euros",               precision: 6, scale: 4, default: 1.0,  null: false
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "directory_adverts", force: :cascade do |t|
    t.integer  "user_id",          limit: 4,                     null: false
    t.integer  "category_id",      limit: 4,                     null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "business_address", limit: 255,                   null: false
    t.string   "postcode",         limit: 255,   default: "",    null: false
    t.string   "opening_hours",    limit: 255,   default: "",    null: false
    t.integer  "resort_id",        limit: 4
    t.string   "phone",            limit: 255,   default: "",    null: false
    t.integer  "image_id",         limit: 4
    t.string   "url",              limit: 255,   default: "",    null: false
    t.string   "strapline",        limit: 255,   default: "",    null: false
    t.text     "description",      limit: 65535
    t.boolean  "is_banner_advert", limit: 1,     default: false, null: false
    t.integer  "banner_image_id",  limit: 4
    t.integer  "width",            limit: 4,     default: 0,     null: false
    t.integer  "height",           limit: 4,     default: 0,     null: false
    t.string   "business_name",    limit: 255,   default: "",    null: false
  end

  add_index "directory_adverts", ["resort_id"], name: "index_directory_adverts_on_resort_id", using: :btree
  add_index "directory_adverts", ["user_id"], name: "index_directory_adverts_on_user_id", using: :btree

  create_table "enquiries", force: :cascade do |t|
    t.integer  "user_id",               limit: 4,                     null: false
    t.integer  "property_id",           limit: 4
    t.string   "name",                  limit: 255,                   null: false
    t.string   "email",                 limit: 255,                   null: false
    t.string   "phone",                 limit: 255,                   null: false
    t.date     "date_of_arrival"
    t.date     "date_of_departure"
    t.text     "comments",              limit: 65535
    t.boolean  "contact_me",            limit: 1,     default: false, null: false
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "number_of_adults",      limit: 4,     default: 0,     null: false
    t.integer  "number_of_children",    limit: 4,     default: 0,     null: false
    t.integer  "number_of_infants",     limit: 4,     default: 0,     null: false
    t.boolean  "permission_to_contact", limit: 1,     default: false, null: false
  end

  create_table "favourites", force: :cascade do |t|
    t.integer  "property_id",          limit: 4, null: false
    t.integer  "unregistered_user_id", limit: 4, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "favourites", ["property_id"], name: "index_favourites_on_property_id", using: :btree
  add_index "favourites", ["unregistered_user_id"], name: "index_favourites_on_unregistered_user_id", using: :btree

  create_table "flip_key_locations", force: :cascade do |t|
    t.integer  "rgt",            limit: 4
    t.string   "parent_path",    limit: 255,             null: false
    t.integer  "parent_id",      limit: 4
    t.string   "name",           limit: 255,             null: false
    t.integer  "lft",            limit: 4
    t.integer  "property_count", limit: 4,   default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "resort_id",      limit: 4
  end

  add_index "flip_key_locations", ["parent_id"], name: "index_flip_key_locations_on_parent_id", using: :btree
  add_index "flip_key_locations", ["resort_id"], name: "index_flip_key_locations_on_resort_id", using: :btree

  create_table "flip_key_properties", force: :cascade do |t|
    t.string   "url",        limit: 255,      null: false
    t.text     "json_data",  limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flip_key_properties", ["url"], name: "index_flip_key_properties_on_url", using: :btree

  create_table "footers", force: :cascade do |t|
    t.string   "name",       limit: 255,   null: false
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "footers", ["name"], name: "index_footers_on_name", using: :btree

  create_table "holiday_type_brochures", force: :cascade do |t|
    t.integer  "brochurable_id",   limit: 4
    t.integer  "holiday_type_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "brochurable_type", limit: 255
  end

  add_index "holiday_type_brochures", ["brochurable_id"], name: "index_holiday_type_brochures_on_brochurable_id", using: :btree
  add_index "holiday_type_brochures", ["holiday_type_id"], name: "index_holiday_type_brochures_on_holiday_type_id", using: :btree

  create_table "holiday_types", force: :cascade do |t|
    t.string   "name",            limit: 255,                  null: false
    t.string   "slug",            limit: 255,                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible_on_menu", limit: 1,     default: true, null: false
    t.text     "sidebar_html",    limit: 65535
    t.text     "mega_menu_html",  limit: 65535
  end

  create_table "images", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "filename",    limit: 255,   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "property_id", limit: 4
    t.text     "source_url",  limit: 65535
  end

  add_index "images", ["property_id"], name: "index_images_on_property_id", using: :btree

  create_table "interhome_accommodations", force: :cascade do |t|
    t.string   "code",               limit: 255,   null: false
    t.string   "name",               limit: 255,   null: false
    t.string   "country",            limit: 255,   null: false
    t.string   "region",             limit: 255,   null: false
    t.string   "place",              limit: 255,   null: false
    t.string   "zip",                limit: 255,   null: false
    t.string   "accommodation_type", limit: 255,   null: false
    t.string   "details",            limit: 255,   null: false
    t.integer  "quality",            limit: 4,     null: false
    t.integer  "brand",              limit: 4,     null: false
    t.integer  "pax",                limit: 4,     null: false
    t.integer  "sqm",                limit: 4,     null: false
    t.integer  "floor",              limit: 4,     null: false
    t.integer  "rooms",              limit: 4,     null: false
    t.integer  "bedrooms",           limit: 4,     null: false
    t.integer  "toilets",            limit: 4,     null: false
    t.integer  "bathrooms",          limit: 4,     null: false
    t.string   "geodata_lat",        limit: 255,   null: false
    t.string   "geodata_lng",        limit: 255,   null: false
    t.text     "features",           limit: 65535
    t.string   "themes",             limit: 255,   null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "permalink",          limit: 255
  end

  add_index "interhome_accommodations", ["code"], name: "index_interhome_accommodations_on_code", using: :btree
  add_index "interhome_accommodations", ["permalink"], name: "index_interhome_accommodations_on_permalink", using: :btree

  create_table "interhome_inside_descriptions", force: :cascade do |t|
    t.string   "accommodation_code", limit: 255,   null: false
    t.text     "description",        limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "interhome_inside_descriptions", ["accommodation_code"], name: "index_interhome_inside_descriptions_on_accommodation_code", using: :btree

  create_table "interhome_outside_descriptions", force: :cascade do |t|
    t.string   "accommodation_code", limit: 255,   null: false
    t.text     "description",        limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "interhome_outside_descriptions", ["accommodation_code"], name: "index_interhome_outside_descriptions_on_accommodation_code", using: :btree

  create_table "interhome_pictures", force: :cascade do |t|
    t.integer  "interhome_accommodation_id", limit: 4,   null: false
    t.string   "picture_type",               limit: 255, null: false
    t.string   "season",                     limit: 255, null: false
    t.string   "url",                        limit: 255, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "interhome_pictures", ["interhome_accommodation_id"], name: "index_interhome_pictures_on_interhome_accommodation_id", using: :btree

  create_table "interhome_place_resorts", force: :cascade do |t|
    t.integer  "resort_id",            limit: 4,   null: false
    t.string   "interhome_place_code", limit: 255, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "interhome_place_resorts", ["resort_id"], name: "index_interhome_place_resorts_on_resort_id", using: :btree

  create_table "interhome_places", force: :cascade do |t|
    t.string   "code",       limit: 255, null: false
    t.string   "name",       limit: 255, null: false
    t.string   "full_name",  limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "interhome_places", ["code"], name: "index_interhome_places_on_code", using: :btree

  create_table "interhome_prices", force: :cascade do |t|
    t.string   "accommodation_code",  limit: 255,             null: false
    t.integer  "days",                limit: 4,               null: false
    t.date     "start_date",                                  null: false
    t.date     "end_date",                                    null: false
    t.integer  "rental_price",        limit: 4,               null: false
    t.integer  "min_rental_price",    limit: 4,               null: false
    t.integer  "max_rental_price",    limit: 4,               null: false
    t.string   "special_offer_code",  limit: 255
    t.integer  "special_offer_price", limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "regular_price",       limit: 4,   default: 0, null: false
  end

  add_index "interhome_prices", ["accommodation_code"], name: "index_interhome_prices_on_accommodation_code", using: :btree

  create_table "interhome_vacancies", force: :cascade do |t|
    t.integer  "interhome_accommodation_id", limit: 4,     null: false
    t.string   "accommodation_code",         limit: 255,   null: false
    t.date     "startday"
    t.text     "availability",               limit: 65535
    t.text     "changeover",                 limit: 65535
    t.text     "minstay",                    limit: 65535
    t.text     "flexbooking",                limit: 65535
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "interhome_vacancies", ["accommodation_code"], name: "index_interhome_vacancies_on_accommodation_code", using: :btree
  add_index "interhome_vacancies", ["interhome_accommodation_id"], name: "index_interhome_vacancies_on_interhome_accommodation_id", using: :btree

  create_table "order_lines", force: :cascade do |t|
    t.integer  "order_id",    limit: 4,               null: false
    t.string   "description", limit: 255,             null: false
    t.integer  "amount",      limit: 4,               null: false
    t.integer  "advert_id",   limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "coupon_id",   limit: 4
    t.integer  "country_id",  limit: 4
    t.integer  "resort_id",   limit: 4
    t.integer  "windows",     limit: 4,   default: 0, null: false
  end

  add_index "order_lines", ["advert_id"], name: "index_order_lines_on_advert_id", using: :btree
  add_index "order_lines", ["country_id"], name: "index_order_lines_on_country_id", using: :btree
  add_index "order_lines", ["coupon_id"], name: "index_order_lines_on_coupon_id", using: :btree
  add_index "order_lines", ["order_id"], name: "index_order_lines_on_order_id", using: :btree
  add_index "order_lines", ["resort_id"], name: "index_order_lines_on_resort_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.string   "order_number",        limit: 255,                                         null: false
    t.string   "email",               limit: 255,                                         null: false
    t.integer  "status",              limit: 4,                                           null: false
    t.string   "name",                limit: 255,                                         null: false
    t.string   "address",             limit: 255,                                         null: false
    t.integer  "country_id",          limit: 4,                                           null: false
    t.string   "phone",               limit: 255,                                         null: false
    t.integer  "total",               limit: 4,                                           null: false
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
    t.string   "postcode",            limit: 255,                         default: "",    null: false
    t.boolean  "pay_monthly",         limit: 1,                           default: false
    t.integer  "first_payment",       limit: 4,                           default: 0
    t.integer  "subsequent_payments", limit: 4,                           default: 0
    t.integer  "tax_amount",          limit: 4,                           default: 0,     null: false
    t.string   "customer_vat_number", limit: 255,                         default: "",    null: false
    t.string   "tax_description",     limit: 255,                         default: "VAT", null: false
    t.decimal  "sterling_in_euros",               precision: 6, scale: 4
  end

  add_index "orders", ["created_at"], name: "index_orders_on_created_at", using: :btree
  add_index "orders", ["email"], name: "index_orders_on_email", using: :btree
  add_index "orders", ["order_number"], name: "index_orders_on_order_number", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "path",                 limit: 255,                  null: false
    t.string   "title",                limit: 255,                  null: false
    t.string   "description",          limit: 255,   default: "",   null: false
    t.string   "keywords",             limit: 255,   default: "",   null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "footer_id",            limit: 4
    t.text     "content",              limit: 65535
    t.text     "banner_advert_html",   limit: 65535
    t.boolean  "visible",              limit: 1,     default: true, null: false
    t.string   "sidebar_snippet_name", limit: 255
    t.string   "header_snippet_name",  limit: 255
    t.integer  "region_id",            limit: 4
    t.integer  "resort_id",            limit: 4
  end

  add_index "pages", ["path"], name: "index_pages_on_path", using: :btree
  add_index "pages", ["region_id"], name: "index_pages_on_region_id", using: :btree
  add_index "pages", ["resort_id"], name: "index_pages_on_resort_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "order_id",           limit: 4
    t.string   "service_provider",   limit: 255
    t.string   "installation_id",    limit: 255
    t.string   "cart_id",            limit: 255
    t.string   "description",        limit: 255
    t.string   "amount",             limit: 255
    t.string   "currency",           limit: 255
    t.boolean  "test_mode",          limit: 1
    t.string   "name",               limit: 255
    t.string   "address",            limit: 255
    t.string   "postcode",           limit: 255
    t.string   "country",            limit: 255
    t.string   "telephone",          limit: 255
    t.string   "fax",                limit: 255
    t.string   "email",              limit: 255
    t.string   "transaction_id",     limit: 255
    t.string   "transaction_status", limit: 255
    t.string   "transaction_time",   limit: 255
    t.text     "raw_auth_message",   limit: 65535
    t.boolean  "accepted",           limit: 1
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "futurepay_id",       limit: 255,   default: "", null: false
  end

  add_index "payments", ["created_at"], name: "index_payments_on_created_at", using: :btree
  add_index "payments", ["order_id"], name: "index_payments_on_order_id", using: :btree

  create_table "properties", force: :cascade do |t|
    t.integer  "user_id",                      limit: 4,                     null: false
    t.integer  "resort_id",                    limit: 4,                     null: false
    t.string   "name",                         limit: 255,   default: "",    null: false
    t.string   "strapline",                    limit: 255,   default: "",    null: false
    t.integer  "metres_from_lift",             limit: 4,     default: 0,     null: false
    t.integer  "sleeping_capacity",            limit: 4,     default: 0,     null: false
    t.integer  "number_of_bedrooms",           limit: 4,     default: 0,     null: false
    t.boolean  "new_development",              limit: 1,     default: false, null: false
    t.integer  "listing_type",                 limit: 4,     default: 0,     null: false
    t.integer  "image_id",                     limit: 4
    t.integer  "weekly_rent_price",            limit: 4,     default: 0,     null: false
    t.boolean  "fully_equipped_kitchen",       limit: 1,     default: false, null: false
    t.integer  "tv",                           limit: 4,     default: 0,     null: false
    t.boolean  "wifi",                         limit: 1,     default: false, null: false
    t.boolean  "disabled",                     limit: 1,     default: false, null: false
    t.integer  "parking",                      limit: 4,     default: 0,     null: false
    t.boolean  "pets",                         limit: 1,     default: false, null: false
    t.boolean  "smoking",                      limit: 1,     default: false, null: false
    t.integer  "sale_price",                   limit: 4,     default: 0,     null: false
    t.boolean  "garden",                       limit: 1,     default: false, null: false
    t.integer  "floor_area_metres_2",          limit: 4,     default: 0,     null: false
    t.integer  "plot_size_metres_2",           limit: 4,     default: 0,     null: false
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.text     "description",                  limit: 65535
    t.integer  "number_of_bathrooms",          limit: 4,     default: 0,     null: false
    t.string   "address",                      limit: 255,   default: "",    null: false
    t.string   "postcode",                     limit: 255,   default: "",    null: false
    t.string   "latitude",                     limit: 255,   default: "",    null: false
    t.string   "longitude",                    limit: 255,   default: "",    null: false
    t.boolean  "long_term_lets_available",     limit: 1,     default: false, null: false
    t.boolean  "balcony",                      limit: 1,     default: false, null: false
    t.boolean  "mountain_views",               limit: 1,     default: false, null: false
    t.boolean  "log_fire",                     limit: 1,     default: false, null: false
    t.boolean  "cave",                         limit: 1,     default: false, null: false
    t.boolean  "ski_in_ski_out",               limit: 1,     default: false, null: false
    t.boolean  "hot_tub",                      limit: 1,     default: false, null: false
    t.boolean  "indoor_swimming_pool",         limit: 1,     default: false, null: false
    t.boolean  "outdoor_swimming_pool",        limit: 1,     default: false, null: false
    t.boolean  "sauna",                        limit: 1,     default: false, null: false
    t.integer  "distance_from_town_centre_m",  limit: 4,     default: 0,     null: false
    t.integer  "accommodation_type",           limit: 4,     default: 0,     null: false
    t.integer  "currency_id",                  limit: 4,     default: 1,     null: false
    t.integer  "normalised_sale_price",        limit: 4,     default: 0,     null: false
    t.integer  "normalised_weekly_rent_price", limit: 4,     default: 0,     null: false
    t.boolean  "children_welcome",             limit: 1,     default: false, null: false
    t.boolean  "short_stays",                  limit: 1,     default: false, null: false
    t.boolean  "terrace",                      limit: 1,     default: false, null: false
    t.integer  "pericles_id",                  limit: 4
    t.integer  "board_basis",                  limit: 4,     default: 0,     null: false
    t.integer  "star_rating",                  limit: 4,     default: 1,     null: false
    t.integer  "interhome_accommodation_id",   limit: 4
    t.integer  "country_id",                   limit: 4
    t.boolean  "publicly_visible",             limit: 1,     default: false, null: false
    t.boolean  "late_availability",            limit: 1,     default: true
    t.integer  "pv_accommodation_id",          limit: 4
    t.integer  "region_id",                    limit: 4
    t.string   "booking_url",                  limit: 255,   default: "",    null: false
    t.integer  "flip_key_property_id",         limit: 4
    t.string   "price_description",            limit: 255,   default: "",    null: false
  end

  add_index "properties", ["country_id"], name: "index_properties_on_country_id", using: :btree
  add_index "properties", ["flip_key_property_id"], name: "index_properties_on_flip_key_property_id", using: :btree
  add_index "properties", ["interhome_accommodation_id"], name: "index_properties_on_interhome_accommodation_id", using: :btree
  add_index "properties", ["late_availability"], name: "index_properties_on_late_availability", using: :btree
  add_index "properties", ["publicly_visible"], name: "index_properties_on_publicly_visible", using: :btree
  add_index "properties", ["pv_accommodation_id"], name: "index_properties_on_pv_accommodation_id", using: :btree
  add_index "properties", ["resort_id"], name: "index_properties_on_resort_id", using: :btree
  add_index "properties", ["user_id"], name: "index_properties_on_user_id", using: :btree

  create_table "property_base_prices", force: :cascade do |t|
    t.integer  "number_of_months", limit: 4, default: 0, null: false
    t.integer  "price",            limit: 4, default: 0, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "property_volume_discounts", force: :cascade do |t|
    t.integer  "current_property_number", limit: 4, default: 0, null: false
    t.integer  "discount_percentage",     limit: 4, default: 0, null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "discount_amount",         limit: 4, default: 0, null: false
  end

  create_table "pv_accommodations", force: :cascade do |t|
    t.string   "name",            limit: 255,   null: false
    t.string   "code",            limit: 255,   null: false
    t.string   "iso_3166_1",      limit: 255,   null: false
    t.string   "iso_3166_2",      limit: 255,   null: false
    t.string   "onu",             limit: 255,   null: false
    t.text     "accroche_liste",  limit: 65535
    t.text     "accroche_fiche",  limit: 65535
    t.text     "description",     limit: 65535
    t.string   "address_1",       limit: 255,   null: false
    t.string   "address_2",       limit: 255,   null: false
    t.string   "town",            limit: 255,   null: false
    t.string   "postcode",        limit: 255,   null: false
    t.string   "latitude",        limit: 255,   null: false
    t.string   "longitude",       limit: 255,   null: false
    t.text     "sports",          limit: 65535
    t.text     "services",        limit: 65535
    t.string   "price_table_url", limit: 255,   null: false
    t.string   "permalink",       limit: 255,   null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "photos",          limit: 65535
  end

  add_index "pv_accommodations", ["code"], name: "index_pv_accommodations_on_code", using: :btree
  add_index "pv_accommodations", ["permalink"], name: "index_pv_accommodations_on_permalink", using: :btree

  create_table "pv_place_resorts", force: :cascade do |t|
    t.integer  "resort_id",     limit: 4,   null: false
    t.string   "pv_place_code", limit: 255, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "pv_place_resorts", ["pv_place_code"], name: "index_pv_place_resorts_on_pv_place_code", using: :btree
  add_index "pv_place_resorts", ["resort_id"], name: "index_pv_place_resorts_on_resort_id", using: :btree

  create_table "pv_vacancies", force: :cascade do |t|
    t.string   "destination_code", limit: 255,                          null: false
    t.string   "apartment_code",   limit: 255,                          null: false
    t.integer  "typology",         limit: 4
    t.date     "start_date",                                            null: false
    t.integer  "duration",         limit: 4,                            null: false
    t.integer  "stock_quantity",   limit: 4,                            null: false
    t.decimal  "base_price",                   precision: 10, scale: 2, null: false
    t.decimal  "promo_price_fr",               precision: 10, scale: 2, null: false
    t.decimal  "promo_price_en",               precision: 10, scale: 2, null: false
    t.decimal  "promo_price_de",               precision: 10, scale: 2, null: false
    t.decimal  "promo_price_nl",               precision: 10, scale: 2, null: false
    t.decimal  "promo_price_es",               precision: 10, scale: 2, null: false
    t.decimal  "promo_price_it",               precision: 10, scale: 2, null: false
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  add_index "pv_vacancies", ["destination_code", "apartment_code"], name: "index_pv_vacancies_on_destination_code_and_apartment_code", using: :btree

  create_table "regions", force: :cascade do |t|
    t.integer  "country_id",     limit: 4
    t.string   "name",           limit: 255,                  null: false
    t.text     "info",           limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",           limit: 255,                  null: false
    t.boolean  "visible",        limit: 1,     default: true, null: false
    t.integer  "property_count", limit: 4,     default: 0,    null: false
  end

  add_index "regions", ["country_id"], name: "index_regions_on_country_id", using: :btree
  add_index "regions", ["slug"], name: "index_regions_on_slug", using: :btree
  add_index "regions", ["visible"], name: "index_regions_on_visible", using: :btree

  create_table "resorts", force: :cascade do |t|
    t.integer  "country_id",             limit: 4,     default: 0,     null: false
    t.string   "name",                   limit: 255,   default: "",    null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.text     "info",                   limit: 65535
    t.integer  "altitude_m",             limit: 4
    t.integer  "top_lift_m",             limit: 4
    t.integer  "piste_length_km",        limit: 4
    t.integer  "black",                  limit: 4
    t.integer  "red",                    limit: 4
    t.integer  "blue",                   limit: 4
    t.integer  "green",                  limit: 4
    t.integer  "longest_run_km",         limit: 4
    t.integer  "drags",                  limit: 4
    t.integer  "chair",                  limit: 4
    t.integer  "gondola",                limit: 4
    t.integer  "cable_car",              limit: 4
    t.integer  "funicular",              limit: 4
    t.integer  "railways",               limit: 4
    t.string   "slope_direction",        limit: 255
    t.integer  "snowboard_parks",        limit: 4
    t.integer  "cross_country_km",       limit: 4
    t.integer  "mountain_restaurants",   limit: 4
    t.boolean  "glacier_skiing",         limit: 1
    t.boolean  "creche",                 limit: 1
    t.boolean  "babysitting_services",   limit: 1
    t.boolean  "visible",                limit: 1,     default: false, null: false
    t.boolean  "featured",               limit: 1,     default: false, null: false
    t.text     "feature",                limit: 65535
    t.text     "introduction",           limit: 65535
    t.string   "season",                 limit: 255,   default: "",    null: false
    t.integer  "beginner",               limit: 4,     default: 0,     null: false
    t.integer  "intermediate",           limit: 4,     default: 0,     null: false
    t.integer  "off_piste",              limit: 4,     default: 0,     null: false
    t.integer  "expert",                 limit: 4,     default: 0,     null: false
    t.boolean  "heli_skiing",            limit: 1
    t.boolean  "summer_skiing",          limit: 1
    t.integer  "family",                 limit: 4,     default: 0,     null: false
    t.text     "visiting",               limit: 65535
    t.text     "owning_a_property_in",   limit: 65535
    t.text     "living_in",              limit: 65535
    t.text     "insider_view",           limit: 65535
    t.text     "weather_code",           limit: 65535
    t.string   "apres_ski",              limit: 255,   default: "",    null: false
    t.boolean  "local_area",             limit: 1,     default: false, null: false
    t.integer  "property_count",         limit: 4,     default: 0,     null: false
    t.integer  "for_rent_count",         limit: 4,     default: 0,     null: false
    t.integer  "for_sale_count",         limit: 4,     default: 0,     null: false
    t.integer  "hotel_count",            limit: 4,     default: 0,     null: false
    t.integer  "new_development_count",  limit: 4,     default: 0,     null: false
    t.text     "gallery_content",        limit: 65535
    t.text     "piste_map_content",      limit: 65535
    t.boolean  "summer_only",            limit: 1,     default: false, null: false
    t.integer  "directory_advert_count", limit: 4,     default: 0,     null: false
    t.integer  "region_id",              limit: 4
    t.string   "slug",                   limit: 255,                   null: false
    t.integer  "ski_area_acre",          limit: 4
  end

  add_index "resorts", ["country_id"], name: "index_resorts_on_country_id", using: :btree
  add_index "resorts", ["featured"], name: "index_resorts_on_featured", using: :btree
  add_index "resorts", ["region_id"], name: "index_resorts_on_region_id", using: :btree
  add_index "resorts", ["slug"], name: "index_resorts_on_slug", using: :btree
  add_index "resorts", ["visible"], name: "index_resorts_on_visible", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",                           limit: 255
    t.boolean  "select_on_signup",               limit: 1
    t.boolean  "admin",                          limit: 1
    t.boolean  "flag_new_development",           limit: 1
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.boolean  "advertises_properties_for_rent", limit: 1,     default: false, null: false
    t.boolean  "advertises_generally",           limit: 1,     default: false, null: false
    t.boolean  "has_business_details",           limit: 1,     default: false, null: false
    t.boolean  "has_a_website",                  limit: 1,     default: false, null: false
    t.boolean  "new_development_by_default",     limit: 1,     default: false, null: false
    t.text     "sales_pitch",                    limit: 65535
    t.boolean  "advertises_properties_for_sale", limit: 1,     default: false, null: false
    t.boolean  "advertises_through_windows",     limit: 1,     default: false, null: false
    t.boolean  "advertises_hotels",              limit: 1,     default: false, null: false
  end

  create_table "snippets", force: :cascade do |t|
    t.string   "name",       limit: 255,   default: "",   null: false
    t.text     "snippet",    limit: 65535
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "locale",     limit: 255,   default: "en", null: false
  end

  add_index "snippets", ["name"], name: "index_snippets_on_name", using: :btree

  create_table "tracked_actions", force: :cascade do |t|
    t.string   "remote_ip",       limit: 255, default: "", null: false
    t.integer  "trackable_id",    limit: 4,                null: false
    t.string   "trackable_type",  limit: 255,              null: false
    t.integer  "action_type",     limit: 4,                null: false
    t.string   "http_user_agent", limit: 255, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tracked_actions", ["created_at"], name: "index_tracked_actions_on_created_at", using: :btree
  add_index "tracked_actions", ["trackable_id", "action_type"], name: "index_tracked_actions_on_trackable_id_and_action_type", using: :btree
  add_index "tracked_actions", ["trackable_id"], name: "index_tracked_actions_on_trackable_id", using: :btree

  create_table "unregistered_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "",    null: false
    t.string   "encrypted_password",     limit: 255
    t.string   "salt",                   limit: 255
    t.string   "website",                limit: 255,   default: "",    null: false
    t.text     "description",            limit: 65535
    t.string   "billing_street",         limit: 255,                   null: false
    t.string   "billing_locality",       limit: 255,   default: "",    null: false
    t.string   "billing_city",           limit: 255,                   null: false
    t.string   "billing_county",         limit: 255,   default: "",    null: false
    t.string   "billing_postcode",       limit: 255,   default: "",    null: false
    t.integer  "billing_country_id",     limit: 4
    t.string   "phone",                  limit: 255,   default: "",    null: false
    t.string   "mobile",                 limit: 255,   default: "",    null: false
    t.string   "business_name",          limit: 255,   default: "",    null: false
    t.string   "position",               limit: 255,   default: "",    null: false
    t.boolean  "terms_and_conditions",   limit: 1,                     null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "role_id",                limit: 4,                     null: false
    t.integer  "coupon_id",              limit: 4
    t.string   "forgot_password_token",  limit: 255,   default: "",    null: false
    t.string   "first_name",             limit: 255,   default: "",    null: false
    t.string   "last_name",              limit: 255,   default: "",    null: false
    t.integer  "image_id",               limit: 4
    t.string   "google_web_property_id", limit: 255,   default: "",    null: false
    t.string   "vat_number",             limit: 255,   default: "",    null: false
    t.integer  "vat_country_id",         limit: 4
    t.boolean  "apply_price_override",   limit: 1,     default: false, null: false
    t.integer  "price_override",         limit: 4,     default: 0,     null: false
    t.text     "enquiry_cc_emails",      limit: 65535
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["last_name"], name: "index_users_on_last_name", using: :btree

  create_table "websites", force: :cascade do |t|
    t.text     "terms",                              limit: 65535
    t.datetime "created_at",                                                                               null: false
    t.datetime "updated_at",                                                                               null: false
    t.text     "privacy_policy",                     limit: 65535
    t.text     "home_content",                       limit: 65535
    t.integer  "directory_advert_price",             limit: 4,                             default: 0,     null: false
    t.text     "start_page_content",                 limit: 65535
    t.string   "worldpay_installation_id",           limit: 255,                           default: "",    null: false
    t.boolean  "worldpay_active",                    limit: 1,                             default: false, null: false
    t.boolean  "worldpay_test_mode",                 limit: 1,                             default: false, null: false
    t.boolean  "skip_payment",                       limit: 1,                             default: false, null: false
    t.string   "worldpay_payment_response_password", limit: 255,                           default: "",    null: false
    t.text     "contact_details",                    limit: 65535
    t.decimal  "vat_rate",                                         precision: 4, scale: 2, default: 20.0,  null: false
    t.text     "resources_banner_html",              limit: 65535
    t.string   "featured_properties_ids",            limit: 255,                           default: "",    null: false
    t.text     "sidebar_html",                       limit: 65535
  end

  create_table "window_base_prices", force: :cascade do |t|
    t.integer  "quantity",   limit: 4, default: 0, null: false
    t.integer  "price",      limit: 4, default: 0, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

end
