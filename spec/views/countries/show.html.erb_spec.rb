require 'spec_helper'

describe 'countries/show' do
  it "displays the country's visible resorts in the quick search form" do
    france = Country.create!(name: 'France', info: 'A country')
    france.resorts << Resort.create!(name: 'Avoriaz', visible: true)
    france.resorts << Resort.create!(name: 'Chamonix', visible: false)
    assign(:country, france)
    assign(:featured_properties, [])
    render
    rendered.should have_content('Avoriaz')
    rendered.should_not have_content('Chamonix')
  end
end
