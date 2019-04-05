# frozen_string_literal: true

class RemoveIsBannerAdvertFromDirectoryAdverts < ActiveRecord::Migration[5.2]
  def change
    remove_column :directory_adverts, :is_banner_advert
  end
end
