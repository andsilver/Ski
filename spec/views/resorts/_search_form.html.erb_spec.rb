require 'rails_helper'

RSpec.describe 'resorts/_search_form.html.erb', type: :view do
  let(:resort) { FactoryGirl.create(:resort) }

  before do
    assign(:resort, resort)
  end

  it 'renders' do
    render
  end
end