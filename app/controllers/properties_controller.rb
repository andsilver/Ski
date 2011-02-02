class PropertiesController < ApplicationController
  def rent
    @properties = @current_user.properties
  end

  def new
    @property = Property.new
  end
end
