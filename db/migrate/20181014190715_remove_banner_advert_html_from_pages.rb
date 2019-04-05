# frozen_string_literal: true

class RemoveBannerAdvertHtmlFromPages < ActiveRecord::Migration[5.2]
  def change
    remove_column :pages, :banner_advert_html
  end
end
