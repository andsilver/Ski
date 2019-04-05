# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Airport distances admin", type: :request do
  before do
    FactoryBot.create(:website)
    allow_any_instance_of(ApplicationController)
      .to receive(:admin?)
      .and_return(true)
  end

  describe "GET /admin/airport_distances" do
    it "lists airport distances" do
      dist = FactoryBot.create(:airport_distance, distance_km: 1234)
      get admin_airport_distances_path
      assert_select "td", content: dist.distance_km
    end
  end

  describe "GET /admin/airport_distances/new" do
    it "shows a form" do
      get new_admin_airport_distance_path
      assert_select "form[action='#{admin_airport_distances_path}']"
    end
  end

  describe "DELETE /admin/airport_distances/:id" do
    let(:distance) { FactoryBot.create(:airport_distance) }
    before { delete admin_airport_distance_path(distance) }

    it "deletes the airport distance" do
      expect(AirportDistance.exists?(distance.id)).to be_falsey
    end

    it "redirects to the airport distances index" do
      expect(response).to redirect_to(admin_airport_distances_path)
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to eq I18n.t("notices.deleted")
    end
  end
end
