# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Advertise", type: :system do
  # In order to manage my contact details and advertisements
  # As an advertiser
  # I want to see my account details

  fixtures :roles, :users, :websites

  scenario "Advertisers are asked to sign up or sign in" do
    visit advertise_path
    expect(page).to have_content("Please sign in or sign up first.")
  end

  scenario "Advertisers see a link to their details and other features" do
    sign_in_as_a_property_owner
    visit advertise_path
    expect_contents ["My Details", "Receipts", "My Email Enquiries"]
  end

  def expect_contents(contents)
    contents.each {|c| expect(page).to have_content(c)}
  end

  scenario "Advertisers can go to the My Details page" do
    sign_in_as_a_property_owner
    visit advertise_path
    click_link "My Details"
    expect(current_path).to eq my_details_path
  end

  scenario "Advertisers can go to the my adverts page" do
    sign_in_as_a_property_owner
    visit advertise_path
    click_link "My Adverts"
    expect(current_path).to eq my_adverts_path
  end
end
