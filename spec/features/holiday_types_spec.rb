require 'spec_helper'

feature "Holiday types" do
  fixtures :holiday_types, :websites

  scenario "Holiday types show in main menu" do
    visit root_path
    expect(page).to have_content('Ski Holidays')
    expect(page).to have_content('Lakes & Mountains')
  end
end
