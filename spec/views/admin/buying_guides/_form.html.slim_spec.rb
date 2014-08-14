require 'rails_helper'

describe 'admin/buying_guides/_form' do
  before do
    assign(:buying_guide, BuyingGuide.new)
  end

  it 'renders' do
    render
  end
end
