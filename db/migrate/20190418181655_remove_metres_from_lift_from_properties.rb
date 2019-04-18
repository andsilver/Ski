class RemoveMetresFromLiftFromProperties < ActiveRecord::Migration[5.2]
  def up
    remove_column :properties, :metres_from_lift
  end

  def down
    add_column :properties, :metres_from_lift, :integer, default: 0, null: false
  end
end
