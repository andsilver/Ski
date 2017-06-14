require 'rails_helper'

RSpec.describe 'enquiries/show.html.erb', type: :view do
  let(:user) { FactoryGirl.create(:user) }
  let(:enquiry) { FactoryGirl.create(:enquiry) }

  before do
    allow(view).to receive(:current_user).and_return(user)
    assign(:enquiry, enquiry)
  end

  it 'renders' do
    render
  end
end
