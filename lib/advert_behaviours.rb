module AdvertBehaviours
  def currently_advertised?
    !current_advert.nil?
  end

  def current_advert
    Advert.where("#{foreign_key} = ? AND expires_at > ?", id, Time.now).first
  end

  def foreign_key
    self.class.to_s + "_id"
  end

  def views
    adverts.inject(0) {|a,b| a + b.views}
  end
end
