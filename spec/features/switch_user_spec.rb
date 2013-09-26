require 'spec_helper'

feature 'Switch user' do
  fixtures :roles, :users, :websites

  scenario 'Switching to a regular user lands on advertise page' do
    user = FactoryGirl.create(:user, first_name: 'RegularUser')
    sign_in_as_admin
    visit switch_user_path(user)
    expect(page).to have_content 'Welcome back, RegularUser'
  end
end
