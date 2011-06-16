class Role < ActiveRecord::Base
  has_many :users

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
end
