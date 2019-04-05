# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Airport transfers", type: :request do
  before { FactoryBot.create(:website) }

  describe "POST /airport_transfers" do
    let(:user) { FactoryBot.create(:user) }
    let(:r1) { FactoryBot.create(:resort) }
    let(:r2) { FactoryBot.create(:resort) }
    let(:airport) { FactoryBot.create(:airport) }

    def perform
      sign_in(user)
      post(
        airport_transfers_path,
        params: {
          transfers: {
            resort_id: [r1.id, r2.id],
            airport_id: airport.id,
          },
        }
      )
    end

    before { perform }

    it "creates an airport transfer record for each selected resort" do
      expect(AirportTransfer.count).to eq 2
    end

    it "redirects to /airport_transfers" do
      expect(response).to redirect_to(airport_transfers_path)
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to eq I18n.t("notices.added")
    end
  end
end
