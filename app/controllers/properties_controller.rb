class PropertiesController < ApplicationController
  def for_rent
    @properties = @current_user.properties
  end

  def new
    @property = Property.new
  end
end
