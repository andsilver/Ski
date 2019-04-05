require "rails_helper"

module TripAdvisor
  RSpec.describe SFTPDetails do
    describe ".default" do
      it "returns default details from secrets.yml" do
        default = SFTPDetails.default
        secrets = Rails.application.secrets

        %i[
          trip_advisor_host trip_advisor_username trip_advisor_password
        ].each { |k| raise "Set #{k} in secrets.yml" if secrets.send(k).nil? }

        expect(default.host).to eq secrets.trip_advisor_host
        expect(default.username).to eq secrets.trip_advisor_username
        expect(default.password).to eq secrets.trip_advisor_password
      end
    end
  end
end
