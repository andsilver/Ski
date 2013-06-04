class BuyingGuide < ActiveRecord::Base
  belongs_to :country

  validates :country, presence: true

  liquid_methods :country, :path

  def path
    "/buying_guides/#{id}"
  end
end
