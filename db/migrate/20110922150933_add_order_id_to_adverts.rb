class AddOrderIdToAdverts < ActiveRecord::Migration
  def change
    add_column :adverts, :order_id, :integer
    add_index :adverts, :order_id
  end
end
