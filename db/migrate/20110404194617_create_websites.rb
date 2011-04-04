class CreateWebsites < ActiveRecord::Migration
  def self.up
    create_table :websites do |t|
      t.text :terms, :default => ''
      t.text :pricing_info, :default => ''

      t.timestamps
    end
  end

  def self.down
    drop_table :websites
  end
end
