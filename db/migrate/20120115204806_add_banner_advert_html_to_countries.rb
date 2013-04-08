class AddBannerAdvertHtmlToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :banner_advert_html, :text
  end
end
