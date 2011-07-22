class AddWindowsToOrderLines < ActiveRecord::Migration
  def change
    add_column :order_lines, :windows, :integer, :default => 0, :null => false
  end
end
