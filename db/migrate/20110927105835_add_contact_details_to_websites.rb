class AddContactDetailsToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :contact_details, :text
  end
end
