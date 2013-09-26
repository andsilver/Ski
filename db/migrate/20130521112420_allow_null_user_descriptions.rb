class AllowNullUserDescriptions < ActiveRecord::Migration
  def up
    change_column :users, :description, :text, null: true
  end

  def down
    change_column :users, :description, :text, null: false
  end
end
