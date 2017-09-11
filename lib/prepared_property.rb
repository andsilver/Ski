# frozen_string_literal: true

class PreparedProperty
  attr_reader :accommodation_key_id, :user

  def initialize(accommodation_key_id, user)
    @accommodation_key_id = accommodation_key_id
    @user = user
  end

  # Prepares a property by finding an existing +Property+ or initializing a
  # new one associated with the given accommodation key => id.
  #
  # If the property exists then its current advert is deleted. The caller
  # should create a new advert.
  #
  # The property is set to publicly_visible and its user is set to @user.
  def property
    prop = Property.find_by(accommodation_key_id)
    if prop
      prop.current_advert.try(:delete)
    else
      prop = Property.new(accommodation_key_id)
    end
    prop.publicly_visible = true
    prop.user = user
    prop
  end
end
