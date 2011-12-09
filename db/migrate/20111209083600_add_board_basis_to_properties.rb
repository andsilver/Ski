class AddBoardBasisToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :board_basis, :integer, :default => 0, :null => false
  end
end
