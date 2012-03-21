class ChangeToListingTypeForProperties < ActiveRecord::Migration
  def up
    change_table :properties do |t|
      t.rename :for_sale, :listing_type
      t.change :listing_type, :integer
    end
  end

  def down
    change_table :properties do |t|
      t.rename :listing_type, :for_sale
      t.change :for_sale, :boolean
    end
  end
end
