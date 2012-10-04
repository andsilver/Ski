class AddTaxDescriptionAndSterlingInEurosToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :tax_description, :string, default: 'VAT', null: false
    add_column :orders, :sterling_in_euros, :decimal, precision: 6, scale: 4, default: nil
  end
end
