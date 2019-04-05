# frozen_string_literal: true

require "rails_helper"

RSpec.describe "TripAdvisor properties", type: :request do
  before { FactoryBot.create(:website) }

  describe "POST /trip_advisor_properties/:id/get_details" do
    let(:prop) do
      FactoryBot.create(
        :trip_advisor_property,
        url: "https://www.tripadvisor.com/FeaturedRentalReview?geo=1&detail=2"
      )
    end

    before do
      post(
        get_details_trip_advisor_property_path(prop),
        params: {
          "check_in" => "7 December, 2017",
          "check_out" => "21 December, 2017",
          "adults" => "1 adult guest",
        }
      )
    end

    it "redirects to the TripAdvisor website with embedded params and MCID " \
    "number for referral attribution" do
      expect(response).to redirect_to(
        "https://www.tripadvisor.com/FeaturedRentalReview?geo=1&detail=2" \
        "&inDay=7&inMonth=12%2F2017&outDay=21&outMonth=12%2F2017&adults=1" \
        "&m=56482"
      )
    end
  end
end
