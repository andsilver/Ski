class AddPrivacyPolicyToWebsites < ActiveRecord::Migration
  def self.up
    add_column :websites, :privacy_policy, :text, :default => ''
  end

  def self.down
    remove_column :websites, :privacy_policy
  end
end
