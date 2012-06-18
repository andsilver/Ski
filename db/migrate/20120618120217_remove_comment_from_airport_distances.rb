class RemoveCommentFromAirportDistances < ActiveRecord::Migration
  def up
    remove_column :airport_distances, :comment
  end

  def down
    add_column :airport_distances, :comment, :string, default: '', null: false
  end
end
