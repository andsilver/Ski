class CreatePvVacancies < ActiveRecord::Migration
  def change
    create_table :pv_vacancies do |t|
      t.string :destination_code, null: false
      t.string :apartment_code, null: false
      t.integer :typology
      t.date :start_date, null: false
      t.integer :duration, null: false
      t.integer :stock_quantity, null: false
      t.decimal :base_price, precision: 10, scale: 2, null: false
      t.decimal :promo_price_fr, precision: 10, scale: 2, null: false
      t.decimal :promo_price_en, precision: 10, scale: 2, null: false
      t.decimal :promo_price_de, precision: 10, scale: 2, null: false
      t.decimal :promo_price_nl, precision: 10, scale: 2, null: false
      t.decimal :promo_price_es, precision: 10, scale: 2, null: false
      t.decimal :promo_price_it, precision: 10, scale: 2, null: false

      t.timestamps
    end

    add_index :pv_vacancies, [:destination_code, :apartment_code]
  end
end
