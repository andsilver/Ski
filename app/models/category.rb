class Category < ActiveRecord::Base
  has_many :directory_adverts, dependent: :restrict_with_exception
  validates_uniqueness_of :name
  validates_presence_of :name

  def to_param
    "#{id}-#{I18n.t(name).parameterize}"
  end

  def to_s
    name
  end
end
