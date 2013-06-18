class AddSlugToRegionsAndResorts < ActiveRecord::Migration
  class Region < ActiveRecord::Base
  end

  class Resort < ActiveRecord::Base
  end

  def change
    add_column :regions, :slug, :string, null: false
    add_index :regions, :slug
    Region.reset_column_information
    Region.all.each do |region|
      region.update_attributes!(slug: region.name.parameterize)
    end

    add_column :resorts, :slug, :string, null: false
    add_index :resorts, :slug
    Resort.reset_column_information
    Resort.all.each do |resort|
      resort.update_attributes!(slug: resort.name.parameterize)
    end
  end
end
