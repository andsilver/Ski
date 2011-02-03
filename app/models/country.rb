class Country < ActiveRecord::Base
  has_many :resorts

  def self.all_valid_for_resorts
    where(:valid_for_resorts => true).order('name')
  end
end
