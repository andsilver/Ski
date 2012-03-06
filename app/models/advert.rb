class Advert < ActiveRecord::Base
  belongs_to :user
  belongs_to :property
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

  def self.assign_window_for(property)
    window = property.user.empty_windows.first
    if window.nil?
      false
    else
      window.property_id = property.id
      window.save
      true
    end
  end

  def self.activate_windows_for_user(how_many, order)
    windows = Advert.where(:order_id => order.id, :window => true)
    if windows.empty?
      how_many.times do
        advert = Advert.new
        advert.order_id = order.id
        advert.user_id = order.user.id
        advert.window = true
        advert.months = 1
        advert.start_and_save!
      end
    else
      windows.each do |w|
        w.expires_at = Time.now + 31.days
        w.save
      end
    end
  end

  def type
    [:directory_advert_id, :property_id].each do |sym|
      return sym.to_s.gsub('_id', '').to_sym unless send(sym).nil?
    end
    nil
  end

  def virtual_type
    if property
      :property
    elsif directory_advert
      if directory_advert.is_banner_advert?
        :banner_advert
      else
        :directory_advert
      end
    end
  end

  def object
    type ? send(type) : nil
  end

  def to_s
    object ? "#{object.name} (#{object.resort.name} #{object.basket_advert_type_description})" : super
  end

  def price(advert_number)
    object ? object.price(self, advert_number) : 0
  end

  def start_and_save!
    self.starts_at = Time.now

    if object && object.current_advert
      self.expires_at = object.current_advert.expires_at + months.months
    else
      self.expires_at = self.starts_at + months.months
    end

    save
  end

  def record_view
    self.views += 1
    save
  end
end
