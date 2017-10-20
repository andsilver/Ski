# frozen_string_literal: true

class DropFlipKeyLocations < ActiveRecord::Migration[5.1]
  def up
    drop_table :flip_key_locations
  end

  def down
    create_table "flip_key_locations", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
      t.integer "rgt"
      t.string "parent_path", null: false
      t.integer "parent_id"
      t.string "name", null: false
      t.integer "lft"
      t.integer "property_count", default: 0, null: false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer "resort_id"
      t.index ["parent_id"], name: "index_flip_key_locations_on_parent_id"
      t.index ["resort_id"], name: "index_flip_key_locations_on_resort_id"
    end
  end
end
