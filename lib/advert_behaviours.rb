module AdvertBehaviours
  def advert_status
    if currently_advertised?
      :live
    elsif user.role.advertises_through_windows? && self.class == Property
      :dormant
    elsif latest_expired_advert
      :expired
    else
      :new
    end
  end

  def currently_advertised?
    !current_advert.nil?
  end

  def current_advert
    Advert.order("expires_at DESC").where("#{self.class.to_s.foreign_key} = ? AND expires_at > ?", id, Time.now).first
  end

  def latest_expired_advert
    Advert.where("#{self.class.to_s.foreign_key} = ? AND expires_at < ?", id, Time.now).first
  end

  def views
    adverts.inject(0) {|a, b| a + b.views}
  end
end
