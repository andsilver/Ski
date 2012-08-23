require 'spec_helper'

describe InterhomeRequest do
  describe '#initialize' do
    it 'stores and makes accessible the details of the request' do
      details = { foo: 'bar' }
      ir = InterhomeRequest.new(details)
      ir.details.should == details
    end
  end
end
