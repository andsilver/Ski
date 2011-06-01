class Advert < ActiveRecord::Base
  belongs_to :user
  belongs_to :property
  belongs_to :banner_advert
  belongs_to :directory_advert

  has_one :order_line

  def self.create_for(object)
    unless basket_contains? object
      advert = Advert.new_for(object)
      advert.months = object.default_months
      advert.save!
    end
  end

  def self.basket_contains?(object)
    object.user.adverts_in_basket.each do |advert|
      if advert.type == object.class.to_s.underscore.to_sym
        if advert.object.id == object.id
          return true
        end
      end
    end
    false
  end

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

  def start_and_save!
    self.starts_at = Time.now
    self.expires_at = Time.now + months.months
    save
  end

  def record_view
    self.views += 1
    save
  end
end
