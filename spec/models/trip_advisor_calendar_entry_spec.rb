# frozen_string_literal: true

require "rails_helper"

RSpec.describe TripAdvisorCalendarEntry, type: :model do
  describe "assocations" do
    it { should belong_to(:trip_advisor_property) }
  end

  describe "validations" do
    it do
      should validate_inclusion_of(:status)
        .in_array(TripAdvisorCalendarEntry::STATUSES)
    end
    it { should validate_presence_of(:inclusive_start) }
    it { should validate_presence_of(:exclusive_end) }
    it { should validate_presence_of(:trip_advisor_property_id) }
  end
end
