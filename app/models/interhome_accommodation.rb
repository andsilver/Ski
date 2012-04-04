class InterhomeAccommodation < ActiveRecord::Base
  has_many :interhome_pictures, :dependent => :delete_all
  has_one :property, :dependent => :destroy

  def inside_description
    desc = InterhomeInsideDescription.find_by_accommodation_code(code)
    desc ? desc.description : ''
  end

  def outside_description
    desc = InterhomeOutsideDescription.find_by_accommodation_code(code)
    desc ? desc.description : ''
  end
end
