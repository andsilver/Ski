class AddPericlesIdToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :pericles_id, :integer
  end
end
