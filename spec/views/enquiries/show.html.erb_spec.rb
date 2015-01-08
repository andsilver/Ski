require 'rails_helper'

RSpec.describe 'enquiries/show.html.erb', type: :view do
  let(:user) { FactoryGirl.create(:user) }
  let(:enquiry) { FactoryGirl.create(:enquiry) }

  before do
    assign(:current_user, user)
    assign(:enquiry, enquiry)
  end

  it 'renders' do
    render
  end
end
