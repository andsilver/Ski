class RemovePricingInfoFromWebsites < ActiveRecord::Migration
  def up
    remove_column :websites, :pricing_info
  end

  def down
    add_column :websites, :pricing_info, :text, :default => ''
  end
end
