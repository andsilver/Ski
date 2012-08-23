class UnregisteredUser < ActiveRecord::Base
  has_many :favourites, dependent: :delete_all
  has_many :favourite_properties, through: :favourites, class_name: 'Property', source: :property
end
