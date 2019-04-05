# frozen_string_literal: true

require "rails_helper"

RSpec.describe "CMS", type: :system do
  # In order to maintain the website and instil confidence in larger customers
  # As a website owner
  # I want a professional, presentable and functional CMS that will allow me to
  # manage the website and demonstrate how we manage the business and how
  # versatile the site is in terms of updating it

  fixtures :roles, :users, :websites

  scenario "Administrators get sent the the CMS home page on signing in" do
    sign_in_as_admin
    expect(current_path).to eq cms_path
  end

  scenario "Administrators should be able to access a how-to guide" do
    sign_in_as_admin
    click_link "CMS Guide"
    expect(current_path).to eq guide_path
  end
end
