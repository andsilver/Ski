class Resort < ActiveRecord::Base
  belongs_to :country
  has_many :properties, :dependent => :nullify
  has_many :order_lines

  scope :featured, where('featured = 1').order('name')

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :country_id

  def to_param
    "#{id}-#{PermalinkFu.escape(name)}"
  end

  def to_s
    name
  end
end
