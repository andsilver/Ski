class AddVisibleToPages < ActiveRecord::Migration
  def change
    add_column :pages, :visible, :boolean, default: true, null: false
  end
end
