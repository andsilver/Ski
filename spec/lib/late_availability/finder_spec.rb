# frozen_string_literal: true

require "rails_helper"

module LateAvailability
  RSpec.describe Finder do
    describe "#find_featured" do
      it "returns at most 5 properties when limit is 5" do
        6.times { create_featured_late_availability_property! }
        finder = Finder.new
        expect(finder.find_featured(limit: 5).length).to eq 5
      end

      it "returns all late availability properties when limit is unset" do
        6.times { create_featured_late_availability_property! }
        finder = Finder.new
        expect(finder.find_featured.length).to eq 6
      end
    end

    def create_featured_late_availability_property!
      @resort ||= FactoryBot.create(:resort)
      @currency ||= Currency.create!(name: "sterling", code: "gbp", in_euros: 1)
      @owner ||= FactoryBot.create(:user)

      Property.create!(
        late_availability: true,
        resort: @resort,
        address: "address",
        name: "property",
        currency: @currency,
        user: @owner
      )
    end
  end
end
