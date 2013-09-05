class InterhomePlaceResort < ActiveRecord::Base
  validates_presence_of :interhome_place_code

  # Returns the full name of the Interhome place if it is found by its code,
  # otherwise returns the code followed by ' (missing)'.
  #
  # :call-seq:
  #   name -> string
  def name
    ip = InterhomePlace.find_by(code: interhome_place_code)
    ip ? ip.full_name : "#{interhome_place_code} (missing)"
  end
end
