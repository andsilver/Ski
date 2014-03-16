class CreateCarouselSlides < ActiveRecord::Migration
  def change
    create_table :carousel_slides do |t|
      t.integer  "position",     null: false
      t.string   "image_url",    null: false
      t.string   "caption",      null: false
      t.string   "link",         null: false
      t.datetime "active_from",  null: false
      t.datetime "active_until", null: false

      t.timestamps
    end
  end
end
