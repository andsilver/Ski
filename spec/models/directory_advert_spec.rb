require "rails_helper"

RSpec.describe DirectoryAdvert, type: :model do
  describe "#to_s" do
    it "returns its business name and resort" do
      resort = Resort.new(name: "Chamonix")
      object = DirectoryAdvert.new(business_name: "McBusiness", resort: resort)
      expect(object.to_s).to eq "McBusiness in Chamonix"
    end
  end

  describe "#price" do
  end

  describe "#clicks" do
    it "returns :click TrackedActions" do
      da = FactoryBot.create(:directory_advert)
      3.times do
        TrackedAction.create(
          action_type: :click,
          trackable_id: da.id,
          trackable_type: "DirectoryAdvert"
        )
      end
      expect(da.reload.clicks.count).to eq 3
    end
  end
end
