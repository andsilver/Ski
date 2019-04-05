# frozen_string_literal: true

require "rails_helper"

RSpec.describe TripAdvisorLocation, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:location_type) }
  end

  describe "associations" do
    it { should have_many(:trip_advisor_properties).dependent(:nullify) }
    it { should belong_to(:resort) }
  end

  describe "acts_as_tree" do
    it { should respond_to(:parent) }
    it { should respond_to(:children) }
  end

  describe "#cascade_resort_id=" do
    it "sets the resort_id of the location" do
      l = TripAdvisorLocation.new
      l.cascade_resort_id = -1
      expect(l.resort_id).to eq(-1)
    end

    it "saves the location" do
      l = FactoryBot.create(:trip_advisor_location)
      l.cascade_resort_id = -1
      expect(l.reload.resort_id).to eq(-1)
    end

    it "sets the resort_id of child locations" do
      l = FactoryBot.create(:trip_advisor_location)
      c = FactoryBot.create(:trip_advisor_location, parent: l)
      l.cascade_resort_id = -1
      expect(c.reload.resort_id).to eq(-1)
    end

    it "does not set the resort_id of other locations" do
      l1 = FactoryBot.create(:trip_advisor_location)
      l2 = FactoryBot.create(:trip_advisor_location)
      l1.cascade_resort_id = -1
      expect(l2.reload.resort_id).not_to eq(-1)
    end
  end
end
