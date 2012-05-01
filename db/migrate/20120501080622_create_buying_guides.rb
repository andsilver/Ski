class CreateBuyingGuides < ActiveRecord::Migration
  def change
    create_table :buying_guides do |t|
      t.integer :country_id, null: false
      t.text :content

      t.timestamps
    end

    add_index :buying_guides, :country_id
  end
end
