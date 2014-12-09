class AddAltToCarouselSlides < ActiveRecord::Migration
  def change
    add_column :carousel_slides, :alt, :string
  end
end
