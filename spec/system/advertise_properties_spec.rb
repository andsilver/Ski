# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Advertise Properties", type: :system do
  fixtures :countries, :currencies, :resorts, :roles, :users, :websites

  let(:booking_url) { "http://example.com/booking.url" }

  scenario "Advertise a new development" do
    sign_in_as_a_property_developer
    click_link "Advertise a Property for Sale"
    fill_in "Property name", with: "Le Centaure"
    check "New development"
    select "France > Chamonix", from: "Resort"
    select "Apartment", from: "Accommodation type"
    fill_in "Address", with: "La Frasse"
    fill_in "Floor area", with: "77"
    fill_in "Plot size", with: "152"
    click_button "Save"

    upload_a_property_image
    expect(page).to have_content "Image uploaded."
  end

  scenario "Advertise a new property for rent" do
    create_a_new_property_for_rent

    property = Property.find_by(
      name: "Chalet Des Sapins",
      booking_url: booking_url
    )
    expect(property).to_not be_nil

    expect(current_path).to eq new_image_path
    expect(page).to have_content "Your property advert was successfully created."
  end

  scenario "Upload an image for new property" do
    create_a_new_property_for_rent

    expect(page).to have_content "Images for Chalet Des Sapins"

    upload_a_property_image
    expect(page).to have_content "Image uploaded."
  end

  scenario "Delete an image for a new property" do
    create_a_new_property_for_rent
    upload_a_property_image

    click_link "Delete"
    expect(page).to have_content "Image deleted."
  end

  def create_a_new_property_for_rent
    sign_in_as_a_property_owner
    click_link "Advertise a Property for Rent"
    fill_in "Property name", with: "Chalet Des Sapins"
    fill_in "Booking URL", with: booking_url
    fill_in "Strapline", with: "Excellent facilities, sleeps 4"
    fill_in "Address", with: "7440"
    fill_in "Weekly rental price from", with: "1650"
    fill_in "Price description", with: "From £165 pp"
    select "< 800m", from: "Distance from town centre"
    select "France > Chamonix", from: "Resort"
    select "4", from: "Capacity"
    select "2", from: "Number of bedrooms"
    select "Freeview", from: "TV"
    select "No parking", from: "Parking"
    check "Pets allowed"
    check "Smoking allowed"
    check "WiFi"
    check "Disabled access"
    check "Fully equipped kitchen"
    select "Classic", from: "Layout"
    click_button "Save"
  end

  def upload_a_property_image
    attach_file "Image", "test-files/banner-image.png"
    click_button "Upload Image"
  end
end
