require 'spec_helper'

describe Role do
  it { should respond_to(:advertises_hotels?) }

  describe "#only_advertises_properties_for_rent?" do
    it "only returns true when there are no other advertising options" do
      role = Role.new
      role.advertises_properties_for_rent = true
      role.advertises_properties_for_sale = false
      role.advertises_generally = false
      role.only_advertises_properties_for_rent?.should be_true

      role.advertises_properties_for_rent = false
      role.only_advertises_properties_for_rent?.should be_false

      role.advertises_properties_for_rent = true
      role.advertises_properties_for_sale = true
      role.only_advertises_properties_for_rent?.should be_false

      role.advertises_properties_for_sale = true
      role.advertises_generally = true
      role.only_advertises_properties_for_rent?.should be_false
    end
  end

  describe "#only_advertises_properties_for_sale?" do
    it "only returns true when there are no other advertising options" do
      role = Role.new
      role.advertises_properties_for_sale = true
      role.advertises_properties_for_rent = false
      role.advertises_generally = false
      role.only_advertises_properties_for_sale?.should be_true

      role.advertises_properties_for_sale = false
      role.only_advertises_properties_for_sale?.should be_false

      role.advertises_properties_for_sale = true
      role.advertises_properties_for_rent = true
      role.only_advertises_properties_for_sale?.should be_false

      role.advertises_properties_for_rent = true
      role.advertises_generally = true
      role.only_advertises_properties_for_sale?.should be_false
    end
  end

  describe "#localisation_key" do
    it "prepends 'roles.'" do
      role = Role.new
      role.name = "admin"
      role.localisation_key.should =="roles.admin"
    end

    it "downcases letters" do
      role = Role.new
      role.name = "Admin"
      role.localisation_key.should =="roles.admin"
    end

    it "substitutes spaces with underscores" do
      role = Role.new
      role.name = "letting agent"
      role.localisation_key.should =="roles.letting_agent"
    end
  end
end
