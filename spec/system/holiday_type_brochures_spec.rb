# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Holiday type brochures", type: :system do
  fixtures :websites

  let(:france) { FactoryBot.create(:country) }
  let(:ski_holidays) { FactoryBot.create(:holiday_type) }

  scenario "Holiday type page lists child resorts" do
    france.holiday_type_brochures.build(holiday_type_id: ski_holidays.id)
    france.save

    FactoryBot.create(:resort, name: "Flaine", country: france)
    morzine = FactoryBot.create(:resort, name: "Morzine", country: france)
    morzine.holiday_type_brochures.build(holiday_type_id: ski_holidays.id)
    morzine.save

    visit holiday_type_brochure_path("countries", france, ski_holidays.slug)
    expect(page.find(".links")).to have_content("Morzine")
    expect(page.find(".links")).not_to have_content("Flaine")
  end
end
