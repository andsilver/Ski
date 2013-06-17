class HolidayTypesController < ApplicationController
  def show
    @holiday_type = HolidayType.find_by(slug: params[:id])
  end
end
