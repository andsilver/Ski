class Website < ActiveRecord::Base
  def featured_properties
    Property.where(id: featured_properties_ids.split)
  end

  def featured_properties=(properties)
    self.featured_properties_ids = properties.map {|p| p.id}.join(" ")
  end

  def vat_for price
    (vat_rate / 100.0) * price
  end
end
