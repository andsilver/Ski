class Advert < ActiveRecord::Base
  belongs_to :user
  belongs_to :property
  belongs_to :directory_advert

  def self.new_for(object)
    advert = Advert.new
    advert.send((object.class.to_s.underscore + "_id=").to_sym, object.id)
    advert.user_id = object.user_id
    advert
  end

  def type
    [:banner_advert_id, :directory_advert_id, :property_id].each do |sym|
      return sym.to_s.gsub('_id', '').to_sym unless send(sym).nil?
    end
    nil
  end

  def object
    send(type)
  end

  def to_s
    object.name
  end

  def price(advert_number)
    object.price(self, advert_number)
  end
end
