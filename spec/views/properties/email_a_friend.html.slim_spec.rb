require 'rails_helper'

RSpec.describe 'properties/email_a_friend.html.slim' do
  let(:property) { FactoryGirl.create(:property) }

  before do
    assign(:property, property)
    assign(:form, EmailAFriendForm.new)
  end

  it 'renders' do
    render
  end
end
