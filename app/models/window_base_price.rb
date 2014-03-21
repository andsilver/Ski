class WindowBasePrice < ActiveRecord::Base
  validates_uniqueness_of :quantity

  def to_s
    "#{quantity} @ #{price}"
  end
end
