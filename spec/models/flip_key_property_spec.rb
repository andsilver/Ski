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
end
