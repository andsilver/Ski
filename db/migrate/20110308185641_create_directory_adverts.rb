class CreateDirectoryAdverts < ActiveRecord::Migration
  def self.up
    create_table :directory_adverts do |t|
      t.integer :user_id, :null => false
      t.integer :category_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :directory_adverts
  end
end
