# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Payments admin", type: :system do
  fixtures :roles, :users, :websites

  scenario "View payment" do
    sign_in_as_admin
    payment = FactoryBot.create(:payment, amount: "1950")
    visit admin_payment_path(payment)
    expect(page).to have_content("View Payment")
    expect(page).to have_content("1950")
  end
end
