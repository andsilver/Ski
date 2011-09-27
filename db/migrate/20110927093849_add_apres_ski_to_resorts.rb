class AddApresSkiToResorts < ActiveRecord::Migration
  def change
    remove_column :resorts, :lively_apres_ski
    add_column :resorts, :apres_ski, :string, :default => '', :null => false
  end
end
