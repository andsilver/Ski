# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Quick search", type: :system do
  before do
    FactoryBot.create(:website)
  end

  scenario "Resort or region is required", js: true do
    pending "need a page with quick search on it"
    visit "/pending"
    accept_prompt "Please choose a resort first." do
      click_button "Search"
    end
  end
end
