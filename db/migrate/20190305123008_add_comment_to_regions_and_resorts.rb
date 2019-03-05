class AddCommentToRegionsAndResorts < ActiveRecord::Migration[5.2]
  def change
    add_column :regions, :comment, :string
    add_column :resorts, :comment, :string
  end
end
