class BuyingGuide < ActiveRecord::Base
  attr_accessible :content, :country_id

  belongs_to :country

  liquid_methods :country, :path

  def path
    "/buying_guides/#{id}"
  end
end
