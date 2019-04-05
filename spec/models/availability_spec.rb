require "rails_helper"

RSpec.describe Availability, type: :model do
  describe "validations" do
    it do
      should validate_inclusion_of(:availability)
        .in_array(Availability::AVAILABILITIES)
    end
    it { should validate_presence_of(:start_date) }
  end

  describe ".delete_past" do
    it "deletes availabilities with start_date before today" do
      FactoryBot.create(:availability, start_date: Date.yesterday)
      Availability.delete_past
      expect(Availability.count).to eq 0
    end

    it "keeps availabilities with start_date of today" do
      FactoryBot.create(:availability, start_date: Date.current)
      Availability.delete_past
      expect(Availability.count).to eq 1
    end
  end
end
