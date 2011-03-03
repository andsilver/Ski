class Resort < ActiveRecord::Base
  belongs_to :country
  has_many :properties, :dependent => :nullify
  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :country_id
end
