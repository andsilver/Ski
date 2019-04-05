class Role < ActiveRecord::Base
  has_many :users

  validates :name, uniqueness: true

  def advertises_properties?
    advertises_properties_for_rent || advertises_properties_for_sale
  end

  def only_advertises_properties_for_rent?
    advertises_properties_for_rent &&
      !advertises_properties_for_sale &&
      !advertises_generally
  end

  def only_advertises_properties_for_sale?
    advertises_properties_for_sale &&
      !advertises_properties_for_rent &&
      !advertises_generally
  end

  def localisation_key
    "roles.#{name.downcase.tr(" ", "_")}"
  end
end
