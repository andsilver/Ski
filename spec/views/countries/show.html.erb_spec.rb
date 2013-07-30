require 'spec_helper'

describe 'countries/show' do
  fixtures :countries, :regions

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

  context 'with regions' do
    let(:country) { countries(:france) }

    it 'displays a regions section' do
      assign(:country, country)
      assign(:featured_properties, [])
      render
      expect(view.content_for(:links_and_search)).to have_content('Regions')
    end
  end

  context 'with only invisible regions' do
    before do
      @country = FactoryGirl.create(:country)
      region = FactoryGirl.create(:region, country: @country, visible: false)
    end

    let(:country) { @country }

    it 'does not display a regions section' do
      expect_no_regions_section
    end
  end

  context 'without regions' do
    let(:country) { FactoryGirl.create(:country) }

    it 'does not display a regions section' do
      expect_no_regions_section
    end
  end

  def expect_no_regions_section
    assign(:country, country)
    assign(:featured_properties, [])
    render
    expect(view.content_for(:links_and_search)).to_not have_content('Regions')
  end
end
