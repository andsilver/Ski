class Footer < ActiveRecord::Base
  attr_accessible :content, :name

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :pages, dependent: :nullify
end
