require 'rails_helper'

feature 'Email a friend' do
  let!(:property) { FactoryGirl.create(:property) }

  background do
    FactoryGirl.create(:website)
  end

  scenario 'Send email to a friend' do
    visit email_a_friend_property_path(property)
    fill_in 'Your name', with: 'Alice Adams'
    fill_in 'Your email', with: 'alice@mychaletfinder.com'
    fill_in 'Friend’s name', with: 'Bob Brown'
    fill_in 'Friend’s email', with: 'bob@mychaletfinder.com'
    expect{click_button 'Send'}.to change{ActionMailer::Base.deliveries.count}.by(1)
  end
end
