require 'rails_helper'

describe FlipKeyProperty do
  let(:fkp) { FlipKeyProperty.new}

  describe '#booked_on?' do
    context 'with no booking calendar' do
      before do
        allow(fkp).to receive(:property_calendar).and_return nil
      end

      it 'returns false' do
        expect(fkp.booked_on?(Date.today)).to be_falsey
      end
    end
  end

  describe '#rate_for_date' do
    let(:pdr) {{
      'date' => 'info'
    }}

    context 'when dates are described as labels' do
      before do
        allow(fkp).to receive(:property_rates).and_return [
          {
            'start_date' => [{}],
            'end_date' => [{}],
            'label' => ['High Season']
          }
        ]
      end

      it 'returns the property default rate' do
        expect(fkp).to receive(:property_default_rate).and_return(pdr)
        expect(fkp.rate_for_date(Date.new)).to eq pdr
      end
    end

    context 'when no rates for given date' do
      before do
        allow(fkp).to receive(:property_rates).and_return []
      end

      it 'returns the property default rate' do
        expect(fkp).to receive(:property_default_rate).and_return(pdr)
        expect(fkp.rate_for_date(Date.new)).to eq pdr
      end
    end
  end

  describe '#city' do
    let(:fk) { FlipKeyProperty.new(json_data: json_data) }
    subject { fk.city }
    context 'when city info is missing' do
      let(:json_data) { '{"property_addresses": [{"city": [{}]}]}' }
      it { should eq '' }
    end
  end

  describe '#amenities' do
    let(:fk) { FlipKeyProperty.new }

    before { allow(fk).to receive(:parsed_json).and_return(amenities) }

    context 'with amenities info present' do
      let(:amenities) { amenities_parsed_json }

      it 'returns a hash of amenities keyed by category' do
        expect(fk.amenities).to eq({
          'Kitchen' => ['Grill', 'Microwave', 'Dishwasher'],
          'Entertainment' => ['Television'],
          'General' => ['Washing Machine', 'Clothes Dryer'],
          'Phone / Internet' => ['Telephone']
          })
      end
    end

    context 'with amenities info missing' do
      let(:amenities) { {"property_amenities"=>[{}]} }

      it 'returns an empty hash' do
        expect(fk.amenities).to eq({})
      end
    end
  end

  def amenities_parsed_json
    {
      "property_amenities"=>[
        {
          "property_amenity"=>[
            {
              "description"=>["Barbecue"],
              "parent_amenity"=>["Kitchen"],
              "site_amenity"=>["Grill"],
              "order"=>["4"]
            },
            {
              "description"=>["Tv"],
              "parent_amenity"=>["Entertainment"],
              "site_amenity"=>["Television"],
              "order"=>["7"]
            },
            {
              "description"=>["Washing machine"],
              "parent_amenity"=>["General"],
              "site_amenity"=>["Washing Machine"],
              "order"=>["13"]
            },
            {
              "description"=>["Microwave"],
              "parent_amenity"=>["Kitchen"],
              "site_amenity"=>["Microwave"],
              "order"=>["12"]
            },
            {
              "description"=>["Telephone"],
              "parent_amenity"=>["Phone / Internet"],
              "site_amenity"=>["Telephone"],
              "order"=>["8"]
            },
            {
              "description"=>["Clothes dryer"],
              "parent_amenity"=>["General"],
              "site_amenity"=>["Clothes Dryer"],
              "order"=>["9"]
            },
            {
              "description"=>["Dish washer"],
              "parent_amenity"=>["Kitchen"],
              "site_amenity"=>["Dishwasher"],
              "order"=>["10"]
            }
          ]
        }
      ]
    }
  end

  describe '.stale' do
    it 'returns properties older than 24 hours' do
      stale = FactoryBot.create(:flip_key_property, updated_at: Time.zone.now - (24.hours + 1.second))
      still_fresh = FactoryBot.create(:flip_key_property, updated_at: Time.zone.now - 23.hours)
      expect(FlipKeyProperty.stale).to include(stale)
      expect(FlipKeyProperty.stale).not_to include(still_fresh)
    end
  end

  describe '.destroy_stale' do
    it 'destroys stale properties' do
      stale = FactoryBot.create(:flip_key_property)
      allow(FlipKeyProperty).to receive(:stale).and_return FlipKeyProperty.all
      FlipKeyProperty.destroy_stale
      expect(FlipKeyProperty.find_by(id: stale.id)).to be_nil
    end
  end
end
