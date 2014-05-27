class AddFlipKeyPropertyIdToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :flip_key_property_id, :integer
    add_index :properties, :flip_key_property_id
  end
end
