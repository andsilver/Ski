require 'spec_helper'

describe 'properties/_featured.html.erb' do
  let(:property) { FactoryGirl.create(:property) }

  context 'with property image' do
    before do
      property.image = Image.new(source_url: 'http://example.org/chalet.png')
    end

    it 'displays the main property image' do
      render partial: 'featured', locals: { p: property }
      expect(rendered).to have_selector 'img[src="http://example.org/chalet.png"]'
    end
  end

  context 'without property image' do
    it 'displays a missing image placeholder' do
      render partial: 'featured', locals: { p: property }
      expect(rendered).to have_selector 'img[alt="Image missing"]'
    end
  end
end

