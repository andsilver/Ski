class HolidayTypesController < ApplicationController
  def show
    @holiday_type = HolidayType.find_by(slug: params[:id])
    not_found unless @holiday_type
  end
end
