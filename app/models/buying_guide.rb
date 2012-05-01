class BuyingGuide < ActiveRecord::Base
  attr_accessible :content, :country_id

  belongs_to :country
end
