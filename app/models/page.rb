class Page < ActiveRecord::Base
  validates_presence_of :path
  validates_presence_of :title

  validates_uniqueness_of :path

  belongs_to :footer
end
