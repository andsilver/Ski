# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Holiday types", type: :system do
  fixtures :countries, :holiday_types, :resorts, :websites

  after(:each) do
    [Country, HolidayType, Resort, Website].each { |c| c.delete_all }
  end

  scenario "Holiday types show in main menu" do
    visit root_path
    expect(page).to have_content("Ski Holidays")
    expect(page).to have_content("Lakes & Mountains")
  end

  scenario "Holiday type page shows content" do
    Page.create!(
      path: "/holidays/ski-holidays",
      title: "Ski Holidays",
      content: "Ski holiday content"
    )
    visit root_path
    click_link "Ski Holidays"
    expect(page).to have_content("Ski holiday content")
  end

  scenario "Holiday type page lists visible countries" do
    countries(:france).holiday_type_brochures.build(holiday_type_id: holiday_types(:ski_holidays).id)
    countries(:france).save!

    countries(:a_country_without_visible_resorts).holiday_type_brochures.build(holiday_type_id: holiday_types(:ski_holidays).id)
    countries(:a_country_without_visible_resorts).save!

    visit holiday_type_path(holiday_types(:ski_holidays))
    expect(page.find(".links li")).to have_content("France")
    expect(page.find(".links li")).not_to have_content("Italy")
    expect(page.find(".links li")).not_to have_content("A Country Without Visible Resorts")
  end
end
