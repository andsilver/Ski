class AddFooterIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :footer_id, :integer
  end
end
