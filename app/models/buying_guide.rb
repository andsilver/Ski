class BuyingGuide < ActiveRecord::Base
  belongs_to :country

  liquid_methods :country, :path

  def path
    "/buying_guides/#{id}"
  end
end
