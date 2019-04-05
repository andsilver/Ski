# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Contact owner", type: :system do
  # In order to express my interest in renting or buying the property
  # and ask further questions that I may have
  # As a tourist
  # I want to contact the owner of a property

  fixtures :countries, :currencies, :properties, :resorts, :users, :websites

  scenario "Contact owner of a property for rent" do
    visit resort_property_rent_path(resorts(:chamonix))
    click_link "Read more about Alpen Lounge"
    click_link "Enquire"
    fill_in "Name", with: "Natalie"
    fill_in "Email", with: "nat@example.org"
    fill_in "Phone", with: "+44.7777123456"
    fill_in "Comments", with: "Are pets welcome?"
    click_button "Send"
    expect(page).to have_content "Thank you for enquiring about this property"
  end

  scenario "Contact owner of a property for sale" do
    visit resort_property_sale_path(resorts(:chamonix))
    click_link "Read more about Chalet Alaska"
    click_link "Enquire"
    expect(page).not_to have_content "Check-in date"
    expect(page).not_to have_content "Check-out date"
    expect(page).not_to have_content "Number of adults"
    expect(page).not_to have_content "Number of children"
    expect(page).not_to have_content "Number of infants"
  end

  scenario "I see instructional messages if I omit required information" do
    visit property_path(properties(:alpen_lounge))
    click_link "Enquire"
    click_button "Send"
    expect(page).to have_content "errors prohibited this enquiry from being sent"
  end
end
