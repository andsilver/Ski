class AddMinStayToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :min_stay, :integer, default: 3, null: false
  end
end
