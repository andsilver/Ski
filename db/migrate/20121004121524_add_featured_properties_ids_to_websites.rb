class AddFeaturedPropertiesIdsToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :featured_properties_ids, :string, default: '', null: false
  end
end
