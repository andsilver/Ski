class AddEnquiryCcEmailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :enquiry_cc_emails, :text
  end
end
