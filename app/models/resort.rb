class Resort < ActiveRecord::Base
  belongs_to :country
  has_many :properties
end
