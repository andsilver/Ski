class AddSlugToCountries < ActiveRecord::Migration
  class Country < ActiveRecord::Base
  end

  def change
    add_column :countries, :slug, :string, null: false
    add_index :countries, :slug
    Country.reset_column_information
    Country.all.each do |country|
      country.update_attributes!(slug: country.name.parameterize)
    end
  end
end
