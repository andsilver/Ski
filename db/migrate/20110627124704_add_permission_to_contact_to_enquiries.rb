class AddPermissionToContactToEnquiries < ActiveRecord::Migration
  def change
    add_column :enquiries, :permission_to_contact, :boolean, :default => false, :null => false
  end
end
