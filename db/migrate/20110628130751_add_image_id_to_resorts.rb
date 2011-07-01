class AddImageIdToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :image_id, :integer
  end
end
