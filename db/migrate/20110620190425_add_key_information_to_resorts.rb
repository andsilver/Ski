class AddKeyInformationToResorts < ActiveRecord::Migration
  def change
    add_column :resorts, :season, :string, :default => '', :null => false
    add_column :resorts, :beginner, :integer, :default => 0, :null => false
    add_column :resorts, :intermediate, :integer, :default => 0, :null => false
    add_column :resorts, :off_piste, :integer, :default => 0, :null => false
    add_column :resorts, :expert, :integer, :default => 0, :null => false
    add_column :resorts, :heli_skiing, :boolean
    add_column :resorts, :summer_skiing, :boolean
    add_column :resorts, :family, :integer, :default => 0, :null => false
    remove_column :resorts, :good_for_families

    add_column :resorts, :how_to_get_to, :text

    add_column :resorts, :visiting, :text
    add_column :resorts, :owning_a_property_in, :text
    add_column :resorts, :summer_holidays_in, :text
    add_column :resorts, :living_in, :text
    add_column :resorts, :insider_view, :text
  end
end
