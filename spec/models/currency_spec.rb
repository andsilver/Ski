# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Currency, type: :model do
  describe 'associations' do
    it { should have_many(:trip_advisor_properties).dependent(:destroy) }
  end

  describe '#to_s' do
    it 'returns its code' do
      currency = Currency.new(code: 'GBP')
      expect(currency.to_s).to eq 'GBP'
    end
  end

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

  describe '.euro' do
    it 'returns the currency whose code is EUR' do
      euro = FactoryGirl.create(:currency, code: 'EUR')
      expect(Currency.euro).to eq euro
    end
  end

  describe '.update_exchange_rates' do
    it "updates each currency's exchange rate" do
      FactoryGirl.create(:currency, code: 'GBP', in_euros: 3)
      FactoryGirl.create(:currency, code: 'USD', in_euros: 3)
      allow(Currency).to receive(:exchange_rates_url).and_return('fakerates')
      rates = StringIO.new(
        '"GBPEUR=X",1.1711,"5/24/2013","11:13am",1.1709,1.1713' + "\n" +
        '"USDEUR=X",0.7742,"5/24/2013","11:13am",0.7741,0.7742'
      )
      allow(Currency).to receive(:open).with('fakerates') { |&block| block.yield rates }
      Currency.update_exchange_rates
      expect(Currency.find_by(code: 'GBP').in_euros).to eq 1.1711
      expect(Currency.find_by(code: 'USD').in_euros).to eq 0.7742
    end
  end

  describe '.exchange_rates_url' do
    it 'returns a Yahoo! URL with a param for each currency in our system' do
      Currency.delete_all
      FactoryGirl.create(:currency, code: 'GBP')
      FactoryGirl.create(:currency, code: 'USD')
      expect(Currency.exchange_rates_url).to eq(
        'http://download.finance.yahoo.com/d/quotes.csv?f=sl1d1t1ba&e=.csv&s=GBPEUR=X,USDEUR=X'
      )
    end
  end
end
