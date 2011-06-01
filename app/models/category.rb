class Category < ActiveRecord::Base
  has_many :directory_adverts, :dependent => :nullify
  validates_uniqueness_of :name
  validates_presence_of :name

  def to_param
    "#{id}-#{PermalinkFu.escape(I18n.t('category_names.' + name))}"
  end

  def to_s
    name
  end
end
