require 'spec_helper'
include LateAvailability

describe '#next_three_saturdays' do
  context 'it is Tue 1 January 2013' do
    it 'returns Sat 5 Jan, 12 Jan, 19 Jan' do
      Date.stub(:today).and_return(Date.new(2013, 1, 1))
      next_three_saturdays.should == [Date.new(2013, 1, 5), Date.new(2013, 1, 12), Date.new(2013, 1, 19)]
    end
  end

  context 'it is Saturday 5 January 2013' do
    it 'returns the next three Saturdays *after* today' do
      Date.stub(:today).and_return(Date.new(2013, 1, 5))
      next_three_saturdays.should == [Date.new(2013, 1, 12), Date.new(2013, 1, 19), Date.new(2013, 1, 26)]
    end
  end
end
