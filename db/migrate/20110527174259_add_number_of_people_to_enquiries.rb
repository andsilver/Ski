class AddNumberOfPeopleToEnquiries < ActiveRecord::Migration
  def change
  	add_column :enquiries, :number_of_adults, :integer, :default => 0, :null => false
  	add_column :enquiries, :number_of_children, :integer, :default => 0, :null => false
  	add_column :enquiries, :number_of_infants, :integer, :default => 0, :null => false
  	remove_column :enquiries, :postcode
  end
end
