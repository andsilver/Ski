require 'spec_helper'

module Interhome
  describe Request do
    describe '#initialize' do
      it 'stores and makes accessible the details of the request' do
        details = { foo: 'bar' }
        ir = Request.new(details)
        ir.details.should == details
      end
    end
  end
end
