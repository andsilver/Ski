# frozen_string_literal: true

class RemoveBannerAdvertHtmlFromCountries < ActiveRecord::Migration[5.2]
  def change
    remove_column :countries, :banner_advert_html
  end
end
