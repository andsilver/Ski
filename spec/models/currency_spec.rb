require 'spec_helper'

describe Currency do
  describe '.sterling_in_euros' do
    it 'finds a currency with code GBP' do
      Currency.should_receive(:find_by_code).with('GBP')
      Currency.sterling_in_euros
    end

    context 'when GBP currency exists' do
      before do
        Currency.stub(:find_by_code).and_return(Currency.new(in_euros: 1.5))
      end

      it 'returns the amount of GBP in Euros' do
        Currency.sterling_in_euros.should == 1.5
      end
    end

    context 'when GBP currency is missing' do
      before { Currency.stub(:find_by_code).and_return(nil) }

      it 'returns 0' do
        Currency.sterling_in_euros.should == 0
      end
    end
  end

  describe '.update_exchange_rates' do
    pending
  end
end
