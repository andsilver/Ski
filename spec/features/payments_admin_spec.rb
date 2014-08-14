require 'rails_helper'

feature 'Payments admin' do
  fixtures :roles, :users, :websites

  scenario 'View payment' do
    sign_in_as_admin
    payment = FactoryGirl.create(:payment, amount: '1950')
    visit payment_path(payment)
    expect(page).to have_content('View Payment')
    expect(page).to have_content('1950')
  end
end
