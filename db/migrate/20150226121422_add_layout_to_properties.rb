class AddLayoutToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :layout, :string
  end
end
