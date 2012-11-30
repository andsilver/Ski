class RemoveHowToGetToFromResorts < ActiveRecord::Migration
  def up
    remove_column :resorts, :how_to_get_to
  end

  def down
    add_column :resorts, :how_to_get_to, :text
  end
end
