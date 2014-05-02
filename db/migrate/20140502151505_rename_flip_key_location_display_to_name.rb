class RenameFlipKeyLocationDisplayToName < ActiveRecord::Migration
  def change
    rename_column :flip_key_locations, :display, :name
  end
end
