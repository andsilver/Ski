class ChangeAvailabilitiesPrimaryKeyToBigInt < ActiveRecord::Migration
  def up
    drop_table :availabilities

    create_table "availabilities", id: false, force: :cascade do |t|
      t.integer  "id",           limit: 8, primary_key: true
      t.integer  "property_id",  limit: 4
      t.date     "start_date"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "availability", limit: 1, null: false
      t.boolean  "check_in",               null: false
      t.boolean  "check_out",              null: false
    end

    add_index "availabilities", ["created_at"], name: "index_availabilities_on_created_at", using: :btree
    add_index "availabilities", ["property_id", "start_date"], name: "index_availabilities_on_property_id_and_start_date", using: :btree
    add_index "availabilities", ["property_id"], name: "index_availabilities_on_property_id", using: :btree
    add_index "availabilities", ["start_date"], name: "index_availabilities_on_start_date", using: :btree
  end

  def down
    drop_table :availabilities

    create_table "availabilities", force: :cascade do |t|
      t.integer  "property_id",  limit: 4
      t.date     "start_date"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "availability", limit: 1, null: false
      t.boolean  "check_in",               null: false
      t.boolean  "check_out",              null: false
    end

    add_index "availabilities", ["created_at"], name: "index_availabilities_on_created_at", using: :btree
    add_index "availabilities", ["property_id", "start_date"], name: "index_availabilities_on_property_id_and_start_date", using: :btree
    add_index "availabilities", ["property_id"], name: "index_availabilities_on_property_id", using: :btree
    add_index "availabilities", ["start_date"], name: "index_availabilities_on_start_date", using: :btree
  end
end
