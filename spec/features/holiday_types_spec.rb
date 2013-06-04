require 'spec_helper'

feature "Holiday types" do
  fixtures :holiday_types, :websites

  scenario "Holiday types show in main menu" do
    visit root_path
    expect(page).to have_content('Ski Holidays')
    expect(page).to have_content('Lakes & Mountains')
  end

  scenario "Holiday type page shows content" do
    Page.create!(
      path: '/holidays/ski-holidays',
      title: 'Ski Holidays',
      content: 'Ski holiday content'
    )
    visit root_path
    click_link 'Ski Holidays'
    expect(page).to have_content('Ski holiday content')
  end
end
