require 'rails_helper'

RSpec.describe 'properties/show_flip_key.html.slim', type: :view do
  let(:flip_key_property) { FactoryGirl.create(:flip_key_property) }
  let(:property) { FactoryGirl.create(:property, flip_key_property: flip_key_property) }

  before do
    FactoryGirl.create(:currency, code: 'USD')
    assign(:property, property.decorate)
    assign(:json, JSON.parse(flip_key_property.json_data))
  end

  it 'renders location as raw HTML' do
    allow(flip_key_property).to receive(:location_description).and_return('Situ&#233; au coeur de')
    render
    expect(rendered).to have_content 'Situé au coeur de'
  end
end
