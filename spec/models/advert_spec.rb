require 'spec_helper'

describe Advert do
  describe "#new_for" do
    it "returns an Advert" do
      Advert.new_for(Property.new({:user_id => 1})).is_a?(Advert).should be_true
    end
  end
end
