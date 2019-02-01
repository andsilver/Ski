# frozen_string_literal: true

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
      if @brochure
        @featured_properties = @brochure.featured_properties(9)
      else
        not_found
      end
    else
      not_found
    end
  end

  protected

  def find_brochurable
    params[:place_type].classify.constantize.find_by(slug: params[:place_slug])
  end
end
