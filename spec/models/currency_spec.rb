require 'spec_helper'

describe Currency do
  describe '.sterling_in_euros' do
    context 'when GBP currency exists' do
      before { FactoryGirl.create(:currency, code: 'GBP', in_euros: 1.5) }

      it 'returns the amount of GBP in Euros' do
        expect(Currency.sterling_in_euros).to eq 1.5
      end
    end

    context 'when GBP currency is missing' do
      it 'returns nil' do
        expect(Currency.sterling_in_euros).to be_nil
      end
    end
  end

  describe '.update_exchange_rates' do
    pending
  end
end
