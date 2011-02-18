class Property < ActiveRecord::Base
  belongs_to :user
  belongs_to :resort
  belongs_to :image

  validates_presence_of :resort_id
  validates_associated :resort

  cattr_reader :per_page
  @@per_page = 10

  def to_param
    "#{id}-#{PermalinkFu.escape(name)}-#{PermalinkFu.escape(resort.name)}-#{PermalinkFu.escape(resort.country.name)}"
  end
end
