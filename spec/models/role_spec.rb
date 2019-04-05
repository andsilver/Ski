require "rails_helper"

RSpec.describe Role, type: :model do
  describe "#only_advertises_properties_for_rent?" do
    it "only returns true when there are no other advertising options" do
      role = Role.new
      role.advertises_properties_for_rent = true
      role.advertises_properties_for_sale = false
      role.advertises_generally = false
      expect(role.only_advertises_properties_for_rent?).to be_truthy

      role.advertises_properties_for_rent = false
      expect(role.only_advertises_properties_for_rent?).to be_falsey

      role.advertises_properties_for_rent = true
      role.advertises_properties_for_sale = true
      expect(role.only_advertises_properties_for_rent?).to be_falsey

      role.advertises_properties_for_sale = true
      role.advertises_generally = true
      expect(role.only_advertises_properties_for_rent?).to be_falsey
    end
  end

  describe "#only_advertises_properties_for_sale?" do
    it "only returns true when there are no other advertising options" do
      role = Role.new
      role.advertises_properties_for_sale = true
      role.advertises_properties_for_rent = false
      role.advertises_generally = false
      expect(role.only_advertises_properties_for_sale?).to be_truthy

      role.advertises_properties_for_sale = false
      expect(role.only_advertises_properties_for_sale?).to be_falsey

      role.advertises_properties_for_sale = true
      role.advertises_properties_for_rent = true
      expect(role.only_advertises_properties_for_sale?).to be_falsey

      role.advertises_properties_for_rent = true
      role.advertises_generally = true
      expect(role.only_advertises_properties_for_sale?).to be_falsey
    end
  end

  describe "#localisation_key" do
    it "prepends 'roles.'" do
      role = Role.new
      role.name = "admin"
      expect(role.localisation_key).to eq "roles.admin"
    end

    it "downcases letters" do
      role = Role.new
      role.name = "Admin"
      expect(role.localisation_key).to eq "roles.admin"
    end

    it "substitutes spaces with underscores" do
      role = Role.new
      role.name = "letting agent"
      expect(role.localisation_key).to eq "roles.letting_agent"
    end
  end
end
