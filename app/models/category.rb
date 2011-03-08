class Category < ActiveRecord::Base
  belongs_to :resort
  validates_uniqueness_of :name, :scope => :resort_id
  validates_presence_of :name

  def to_param
    "#{id}-#{PermalinkFu.escape(name)}"
  end
end
