class CreateInterhomeVacancies < ActiveRecord::Migration
  def change
    create_table :interhome_vacancies do |t|
      t.integer :interhome_accommodation_id, null: false
      t.string :accommodation_code, null: false
      t.date :startday
      t.text :availability
      t.text :changeover
      t.text :minstay
      t.text :flexbooking

      t.timestamps
    end

    add_index :interhome_vacancies, :interhome_accommodation_id
    add_index :interhome_vacancies, :accommodation_code
  end
end
