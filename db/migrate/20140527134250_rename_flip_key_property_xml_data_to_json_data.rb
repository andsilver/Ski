class RenameFlipKeyPropertyXmlDataToJsonData < ActiveRecord::Migration
  def up
    rename_column :flip_key_properties, :xml_data, :json_data
    change_column :flip_key_properties, :json_data, :text, limit: 64.kilobytes + 1
  end

  def down
    change_column :flip_key_properties, :json_data, :text
    rename_column :flip_key_properties, :json_data, :xml_data
  end
end
