require 'spec_helper'

describe PropertiesHelper do
  describe '#featured_properties' do
    it 'returns an empty string when properties is nil' do
      expect(featured_properties(nil)).to eq ''
    end

    it 'renders no more than 3 properties' do
      properties = []
      4.times { properties << FactoryGirl.create(:property) }
      html = featured_properties(properties)
      expect(html).to have_selector("[title='#{properties[2].name}']")
      expect(html).not_to have_selector("[title='#{properties[3].name}']")
    end
  end

  describe '#hotel_booking_url' do
    let(:property) { FactoryGirl.build(:property, booking_url: booking_url) }

    context 'when property has the booking URL set' do
      let(:booking_url) { '#hotel' }

      it 'returns the booking URL' do
        expect(hotel_booking_url(property)).to eq '#hotel'
      end
    end

    context 'when property has no booking URL set' do
      let(:booking_url) { '' }

      it 'returns a contact_property_path' do
        expect(hotel_booking_url(property)).to eq contact_property_path(property)
      end
    end
  end
end
