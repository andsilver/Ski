class AddVatRateToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :vat_rate, :decimal, :precision => 4, :scale => 2, :default => 20.0, :null => false
  end
end
