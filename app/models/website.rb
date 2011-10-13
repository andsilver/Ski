class Website < ActiveRecord::Base
  def vat_for price
    (vat_rate / 100.0) * price
  end
end
