class Country < ActiveRecord::Base
  has_many :resorts

  def self.all_with_resorts
    all(:order => :name)
  end
end
