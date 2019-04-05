# frozen_string_literal: true

class Advert < ActiveRecord::Base
  belongs_to :user
  belongs_to :property, optional: true
  belongs_to :directory_advert, optional: true

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

  def self.activate_windows_for_user(how_many, order, months)
    windows = Advert.where(order_id: order.id, window: true)
    if windows.empty?
      how_many.times do
        advert = Advert.new
        advert.order_id = order.id
        advert.user_id = order.user.id
        advert.window_spot = true
        advert.months = months
        advert.start_and_save!
      end
    else
      windows.each do |w|
        w.expires_at = Time.now + days_for_months(months)
        w.save
      end
    end
  end

  def expired?
    expires_at < Time.now
  end

  def type
    [:directory_advert_id, :property_id].each do |sym|
      return sym.to_s.gsub("_id", "").to_sym unless send(sym).nil?
    end
    nil
  end

  def virtual_type
    if property
      :property
    elsif directory_advert
      :directory_advert
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

    self.expires_at = if object&.current_advert
      object.current_advert.expires_at + days
    else
      starts_at + days
    end

    save
  end

  # Returns a more optimistic number of days for the advert's number of months
  # than Rails.
  #
  #   Advert.new(months: 1).days  # => 31 days
  #   Advert.new(months: 12).days # => 366 days
  def days
    Advert.days_for_months(months)
  end

  def self.days_for_months(months)
    (months * 30.5).ceil.days
  end

  # Records a view or impression of this advert and saves the model.
  def record_view
    self.views += 1
    save
  end

  # Returns true if this advert both starts at and expires at before now.
  def old?
    starts_at && (starts_at + days < Time.zone.now && expires_at < Time.zone.now)
  end
end
