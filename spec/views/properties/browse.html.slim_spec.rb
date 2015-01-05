require 'rails_helper'

describe 'properties/browse' do
  let(:resort) { FactoryGirl.create(:resort) }

  before do
    assign(:breadcrumbs, {})
    assign(:properties, [])
    assign(:search_filters, [])
  end

  context 'when resort' do
    before { assign(:resort, resort) }

    context 'when ski resort' do
      before { allow(resort).to receive(:ski?).and_return(true) }

      it 'includes the distance from lift sort method' do
        render
        expect(view.content_for(:links_and_search)).to have_content(t 'properties.browse.distance_from_lift')
      end
    end

    context 'when not ski resort' do
      before { allow(resort).to receive(:ski?).and_return(false) }

      it 'excludes the distance from lift sort method' do
        render
        no_distance_from_lift
      end
    end
  end

  context 'when not resort' do
    it 'excludes the distance from lift sort method' do
      render
      no_distance_from_lift
    end
  end

  context 'when search results page type is :sales' do
    before { allow(view).to receive(:search_results_page_type).and_return(:sales) }

    it 'contains a sale price sorting method' do
      render
      expect(links_and_search).to have_selector 'option[value="normalised_sale_price DESC"]'
    end

    it 'contains a number of bathrooms sorting method' do
      render
      expect(links_and_search).to have_selector 'option[value="number_of_bathrooms ASC"]'
    end
  end

  context 'when search results page type is :rentals' do
    before { allow(view).to receive(:search_results_page_type).and_return(:rentals) }

    it 'contains a rental price sorting method' do
      render
      expect(links_and_search).to have_selector 'option[value="normalised_weekly_rent_price DESC"]'
    end

    it 'contains a sleeping capacity sorting method' do
      render
      expect(links_and_search).to have_selector 'option[value="sleeping_capacity ASC"]'
    end
  end

  def links_and_search
    view.content_for(:links_and_search)
  end

  context 'with results' do
    let(:property) { FactoryGirl.create(:property) }
    let(:properties) { [property] }

    before do
      allow(properties).to receive(:total_pages).and_return(1)
      assign(:properties, properties)
    end
  end

  def no_distance_from_lift
    expect(view.content_for(:links_and_search)).not_to have_content(t 'properties.browse.distance_from_lift')
  end
end
