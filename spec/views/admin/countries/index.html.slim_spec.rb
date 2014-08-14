require 'rails_helper'

describe 'admin/countries/index' do
  let(:country) { FactoryGirl.create(:country) }

  before do
    assign(:countries, [country])
  end

  it 'renders' do
    render
  end
end
