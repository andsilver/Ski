require 'rails_helper'

RSpec.describe 'resorts/gallery.html.slim', type: :view do
  let(:resort) { FactoryGirl.create(:resort) }

  before do
    assign(:resort, resort)
  end

  it 'renders' do
    render
  end
end
