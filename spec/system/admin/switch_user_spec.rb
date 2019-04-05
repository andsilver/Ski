# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Switch user", type: :system do
  fixtures :roles, :users, :websites

  let!(:user) { FactoryBot.create(:user, first_name: "RegularUser") }

  scenario "Switching to a regular user lands on advertise page" do
    sign_in_as_admin
    visit switch_user_path(user)
    expect(page).to have_content "Welcome back, RegularUser"
  end

  scenario "Signing out as regular user switches back to admin", js: true do
    sign_in_as_admin
    visit switch_user_path(user)
    click_link I18n.t("sign_out")
    expect(page).to have_content "CMS"
  end
end
