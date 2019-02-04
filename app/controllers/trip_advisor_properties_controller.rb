# frozen_string_literal: true

class TripAdvisorPropertiesController < ApplicationController
  def get_details
    prop = TripAdvisorProperty.find(params[:id])
    check_in = Date.parse(params[:check_in] || params[:start_date])
    check_out = Date.parse(params[:check_out] || params[:end_date])
    adults = params[:adults].to_i

    url = "#{prop.url}&inDay=#{check_in.day}&inMonth=#{check_in.month}%2F" \
    "#{check_in.year}&outDay=#{check_out.day}&outMonth=#{check_out.month}%2F" \
    "#{check_out.year}&adults=#{adults}&m=56482"

    redirect_to url
  end
end
