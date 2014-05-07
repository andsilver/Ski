require 'spec_helper'

describe 'properties/_featured.html.erb' do
  let(:property) { FactoryGirl.create(:property) }

  context 'with property image' do
    before do
      property.image = mock_model(Image, url: '/up/images/chalet.png')
    end

    it 'displays the main property image' do
      render partial: 'featured', locals: { p: property }
      expect(rendered).to have_selector 'img[src="/up/images/chalet.png"]'
    end
  end

  context 'without property image' do
    it 'displays a missing image placeholder' do
      render partial: 'featured', locals: { p: property }
      expect(rendered).to have_selector 'img[alt="Image missing"]'
    end
  end
end

