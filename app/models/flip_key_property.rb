class FlipKeyProperty < ActiveRecord::Base
  has_one :property, dependent: :destroy
end
