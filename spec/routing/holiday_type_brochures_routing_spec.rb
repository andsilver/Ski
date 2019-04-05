# frozen_string_literal: true

require "rails_helper"

RSpec.describe "HolidayTypeBrochures routing", type: :routing do
  it "routes known place types" do
    ["countries", "regions", "resorts"].each do |place_type|
      expect(
        get: "/#{place_type}/chamonix/holidays/ski-holidays"
      ).to route_to(
        controller: "holiday_type_brochures",
        action: "show",
        place_type: place_type,
        place_slug: "chamonix",
        holiday_type_slug: "ski-holidays"
      )
    end
  end

  it "does not route non-place types" do
    expect(
      get: "/pages/chamonix/holidays/ski-holidays"
    ).not_to route_to(
      controller: "holiday_type_brochures",
      action: "show",
      place_type: "pages",
      place_slug: "chamonix",
      holiday_type_slug: "ski-holidays"
    )
  end
end
