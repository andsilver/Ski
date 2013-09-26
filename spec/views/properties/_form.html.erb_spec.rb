require 'spec_helper'

describe 'properties/_form' do
  fixtures :roles, :users

  context 'with a property developer' do
    before do
      assign(:current_user, users(:bob)) # a property developer
    end

    context 'with a property for sale' do
      before do
        assign(:property, Property.new(listing_type: Property::LISTING_TYPE_FOR_SALE))
        render
      end

      it 'shows a new development checkbox' do
        expect(rendered).to have_selector('input#property_new_development')
      end
    end

    context 'with a property for rent' do
      before do
        assign(:property, Property.new(listing_type: Property::LISTING_TYPE_FOR_RENT))
        render
      end

      it 'does not show a new development checkbox' do
        expect(rendered).not_to have_selector('input#property_new_development')
      end
    end
  end
end
