class HolidayTypeBrochuresController < ApplicationController
  def show
    @brochurable = find_brochurable
    @holiday_type = HolidayType.find_by(slug: params[:holiday_type_slug])
    
    if @brochurable && @holiday_type
      @brochure = HolidayTypeBrochure.find_by(
        brochurable_id: @brochurable.id,
        brochurable_type: @brochurable.class.to_s,
        holiday_type_id: @holiday_type.id
      )
      @featured_properties = @brochure.featured_properties(9)
    elsif @brochurable
      redirect_to @brochurable, notice: 'That information is missing.'
    elsif @holiday_type
      redirect_to @holiday_type, notice: 'That place does not exist.'
    else
      not_found
    end
  end

  protected

    def find_brochurable
      params[:place_type].classify.constantize.find_by(slug: params[:place_slug])
    end
end
