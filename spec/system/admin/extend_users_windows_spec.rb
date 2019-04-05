# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Extend a user's windows", type: :system do
  fixtures :users, :roles

  let(:advertiser) { FactoryBot.create(:a_property_developer) }
  let!(:advert) do
    Advert.create(
      user: advertiser, window_spot: true, starts_at: Time.zone.now,
      expires_at: "2015-01-01"
    )
  end

  before do
    FactoryBot.create(:website)
    sign_in_as_admin
  end

  scenario "View a user's adverts starting from the admin user list" do
    visit admin_users_path
    click_link "View #{advertiser}'s adverts"
    fill_in "Days", with: "365"
    click_button "Extend Windows"
    expect(advert.reload.expires_at).to eq Time.parse("2016-01-01")
  end
end
