class Advert < ActiveRecord::Base
  belongs_to :user
  belongs_to :property

  def self.new_for(object)
    advert = Advert.new
    advert.send((object.class.to_s + "_id=").downcase.to_sym, object.id)
    advert.user_id = object.user_id
    advert
  end
end
