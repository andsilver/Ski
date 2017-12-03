# frozen_string_literal: true

class DropFlipKeyProperties < ActiveRecord::Migration[5.1]
  def up
    drop_table :flip_key_properties
  end

  def down
    create_table "flip_key_properties", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
      t.string "url", null: false
      t.text "json_data", limit: 16777215
      t.datetime "created_at"
      t.datetime "updated_at"
      t.index ["url"], name: "index_flip_key_properties_on_url"
    end
  end
end
