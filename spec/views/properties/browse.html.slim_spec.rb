require 'spec_helper'

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
      before { resort.stub(:ski?).and_return(true) }

      it 'includes the distance from lift sort method' do
        render
        expect(view.content_for(:links_and_search)).to have_content(t 'properties.browse.distance_from_lift')
      end
    end

    context 'when not ski resort' do
      before { resort.stub(:ski?).and_return(false) }

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

  def no_distance_from_lift
    expect(view.content_for(:links_and_search)).not_to have_content(t 'properties.browse.distance_from_lift')
  end
end
