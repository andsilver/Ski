class AddIndexOnCreatedAtToUnavailabilities < ActiveRecord::Migration
  def change
    add_index :unavailabilities, :created_at
  end
end
