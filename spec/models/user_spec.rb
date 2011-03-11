require 'spec_helper'

describe User do
  describe "#has_properties_for_rent?" do
    it "returns true when there are one or more properties for rent" do
      user = User.new
      user.stub(:properties_for_rent).and_return([:a_property])
      user.has_properties_for_rent?.should be_true
    end

    it "returns false when there are 0 properties for rent" do
      user = User.new
      user.stub(:properties_for_rent).and_return([])
      user.has_properties_for_rent?.should be_false
    end
  end

  describe "#has_properties_for_sale?" do
    it "returns true when there are one or more properties for sale" do
      user = User.new
      user.stub(:properties_for_sale).and_return([:a_property])
      user.has_properties_for_sale?.should be_true
    end

    it "returns false when there are 0 properties for sale" do
      user = User.new
      user.stub(:properties_for_sale).and_return([])
      user.has_properties_for_sale?.should be_false
    end
  end
end
