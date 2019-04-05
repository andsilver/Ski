require "rails_helper"

RSpec.describe "Trip Advisor locations admin", type: :request do
  before do
    FactoryBot.create(:website)
    allow_any_instance_of(ApplicationController)
      .to receive(:admin?)
      .and_return(true)
  end

  describe "GET /admin/trip_advisor_locations" do
    it "lists each top-level location" do
      africa = FactoryBot.create(
        :trip_advisor_location, name: "Africa", parent: nil
      )
      FactoryBot.create(
        :trip_advisor_location, name: "Madagascar", parent: africa
      )

      get admin_trip_advisor_locations_path

      assert_select "li", text: "Africa"
      assert_select "li", text: "Madagascar", count: 0
    end
  end

  describe "GET /admin/trip_advisor_locations/:id" do
    let!(:africa) do
      FactoryBot.create(:trip_advisor_location, name: "Africa", parent: nil)
    end
    let!(:madagascar) do
      FactoryBot.create(
        :trip_advisor_location, name: "Madagascar", parent: africa
      )
    end

    it "links to its child locations" do
      get admin_trip_advisor_location_path(africa)
      assert_select "a[href='#{admin_trip_advisor_location_path(madagascar)}']"
    end

    it "links to its parent location" do
      get admin_trip_advisor_location_path(madagascar)
      assert_select "a[href='#{admin_trip_advisor_location_path(africa)}']"
    end

    it "displays a form to link the location to a resort" do
      get admin_trip_advisor_location_path(madagascar)
      assert_select(
        "form[action='#{admin_trip_advisor_location_path(madagascar)}']"
      ) do
        assert_select 'select[name="trip_advisor_location[resort_id]"]'
        assert_select "input[type=submit]"
      end
    end
  end

  describe "PATCH /admin/trip_advisor_locations/:id" do
    let(:resort) { FactoryBot.create(:resort) }
    let!(:africa) do
      FactoryBot.create(:trip_advisor_location, name: "Africa", parent: nil)
    end
    let!(:madagascar) do
      FactoryBot.create(
        :trip_advisor_location, name: "Madagascar", parent: africa
      )
    end

    def perform
      patch admin_trip_advisor_location_path(
        africa, params: {
          trip_advisor_location: {resort_id: resort.id},
        }
      )
    end

    it "updates location's resort recursively" do
      perform
      expect(africa.reload.resort).to eq resort
      expect(madagascar.reload.resort).to eq resort
    end

    it "sets a flash notice" do
      perform
      expect(flash[:notice]).to eq "Updated."
    end

    it "redirects to the location page" do
      perform
      expect(response)
        .to redirect_to(admin_trip_advisor_location_path(africa))
    end
  end
end
