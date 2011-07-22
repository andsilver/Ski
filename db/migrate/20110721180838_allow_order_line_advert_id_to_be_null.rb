class AllowOrderLineAdvertIdToBeNull < ActiveRecord::Migration
  def up
    change_column :order_lines, :advert_id, :integer, :default => nil, :null => true
  end

  def down
    change_column :order_lines, :advert_id, :integer, :default => 0, :null => false
  end
end
