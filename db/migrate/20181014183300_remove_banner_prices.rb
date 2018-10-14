# frozen_string_literal: true

class RemoveBannerPrices < ActiveRecord::Migration[5.2]
  def change
    drop_table :banner_prices
  end
end
