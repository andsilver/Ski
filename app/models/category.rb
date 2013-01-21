class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :directory_adverts, dependent: :nullify
  validates_uniqueness_of :name
  validates_presence_of :name

  def to_param
    "#{id}-#{I18n.t(name).parameterize}"
  end

  def to_s
    name
  end
end
