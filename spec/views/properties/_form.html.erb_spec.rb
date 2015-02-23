require 'rails_helper'

describe 'properties/_form' do
  fixtures :roles, :users

  context 'with a property developer' do
    before do
      assign(:current_user, users(:bob)) # a property developer
      allow(view).to receive(:admin?).and_return(false)
    end

    it 'renders listing_type as a hidden field' do
      assign(:property, Property.new)
      render
      expect(rendered).to have_selector('input[type="hidden"]#property_listing_type')
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

  context 'when admin' do
    before do
      allow(view).to receive(:admin?).and_return(true)
      assign(:current_user, users(:tony)) # an administrator
    end

    it 'renders listing_type as a select field' do
      assign(:property, Property.new)
      render
      expect(rendered).to have_selector('select#property_listing_type')
    end
  end
end
