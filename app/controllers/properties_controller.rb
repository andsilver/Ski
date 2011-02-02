class PropertiesController < ApplicationController
  def browse_for_rent
    @resort = Resort.find(params[:id])
    @properties = @resort.properties
  end

  def my_for_rent
    @properties = @current_user.properties
  end

  def new
    @property = Property.new
  end
end
