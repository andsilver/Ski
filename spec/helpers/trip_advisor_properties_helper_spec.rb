# frozen_string_literal: true

require "rails_helper"

RSpec.describe TripAdvisorPropertiesHelper, type: :helper do
  describe "#javascript_check_out_dates" do
    it "returns a JavaScript mapping of check in to check out dates" do
      ci1 = Date.new(2014, 8, 23)
      ci2 = Date.new(2014, 8, 30)
      co1 = Date.new(2014, 8, 30)
      co2 = Date.new(2014, 9, 6)
      co3 = Date.new(2014, 9, 6)
      prop = instance_double(
        TripAdvisorProperty,
        check_in_dates: [ci1, ci2]
      )
      allow(prop).to receive(:check_out_dates).with(ci1).and_return([co1, co2])
      allow(prop).to receive(:check_out_dates).with(ci2).and_return([co3])

      expect(javascript_check_out_dates(prop)).to eq(
        "'2014-08-23': [true, new Date(2014,8-1,30), new Date(2014,9-1,6)],\n" \
        "'2014-08-30': [true, new Date(2014,9-1,6)]"
      )
    end
  end
end
