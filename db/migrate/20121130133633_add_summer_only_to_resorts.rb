class AddSummerOnlyToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :summer_only, :boolean, default: false, null: false
  end
end
