# frozen_string_literal: true

class RemovePierreEtVacances < ActiveRecord::Migration[5.1]
  def change
    drop_table :pv_vacancies
    drop_table :pv_place_resorts
    remove_column :properties, :pv_accommodation_id
    drop_table :pv_accommodations
  end
end
