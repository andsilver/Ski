# frozen_string_literal: true

class RemoveBannerImageIdFromDirectoryAdverts < ActiveRecord::Migration[5.2]
  def change
    remove_column :directory_adverts, :banner_image_id
  end
end
