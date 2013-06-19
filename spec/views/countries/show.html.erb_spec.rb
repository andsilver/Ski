require 'spec_helper'

describe 'countries/show' do
  fixtures :countries

  it "displays the country's visible resorts in the quick search form" do
    france = countries(:france)
    france.resorts << Resort.create!(name: 'Avoriaz', visible: true, slug: 'avoriaz')
    france.resorts << Resort.create!(name: 'Tignes', visible: false, slug: 'tignes')
    assign(:country, france)
    assign(:featured_properties, [])
    render
    expect(view.content_for(:links_and_search)).to have_content('Avoriaz')
    expect(view.content_for(:links_and_search)).to_not have_content('Tignes')
  end
end
