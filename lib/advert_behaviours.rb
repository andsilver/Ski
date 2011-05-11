module AdvertBehaviours
  def currently_advertised?
    !current_advert.nil?
  end

  def current_advert
    Advert.where("#{self.class.to_s.foreign_key} = ? AND expires_at > ?", id, Time.now).first
  end

  def views
    adverts.inject(0) {|a,b| a + b.views}
  end
end
