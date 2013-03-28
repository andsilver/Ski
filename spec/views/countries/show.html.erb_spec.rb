require 'spec_helper'

describe 'countries/show' do
  fixtures :countries

  it "displays the country's visible resorts in the quick search form" do
    france = countries(:france)
    france.resorts << Resort.create!(name: 'Avoriaz', visible: true)
    france.resorts << Resort.create!(name: 'Tignes', visible: false)
    assign(:country, france)
    assign(:featured_properties, [])
    render
    rendered.should have_content('Avoriaz')
    rendered.should_not have_content('Tignes')
  end
end
