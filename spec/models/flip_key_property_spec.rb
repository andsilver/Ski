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
    context 'when no rates for given date' do
      before do
        allow(fkp).to receive(:property_rates).and_return []
      end

      it 'returns the property default rate' do
        pdr = {
          'date' => 'info'
        }
        expect(fkp).to receive(:property_default_rate).and_return(pdr)
        expect(fkp.rate_for_date(Date.new)).to eq pdr
      end
    end
  end

  describe '#amenities' do
    it 'returns a hash of amenities keyed by category' do
      fk = FlipKeyProperty.new
      allow(fk).to receive(:parsed_json).and_return(amenities_parsed_json)
      expect(fk.amenities).to eq({
        'Kitchen' => ['Grill', 'Microwave', 'Dishwasher'],
        'Entertainment' => ['Television'],
        'General' => ['Washing Machine', 'Clothes Dryer'],
        'Phone / Internet' => ['Telephone']
        })
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
end
