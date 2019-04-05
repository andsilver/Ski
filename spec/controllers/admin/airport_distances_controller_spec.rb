require "rails_helper"

module Admin
  RSpec.describe AirportDistancesController, type: :controller do
    let(:website) { Website.new }
    let(:current_user) { FactoryBot.build(:user) }
    let(:airport_distance) { double(AirportDistance).as_null_object }

    before do
      allow(Website).to receive(:first).and_return(website)
      allow(controller).to receive(:admin?).and_return(true)
    end

    def post_params
      {airport_distance: {"airport_id" => "1", "distance_km" => "20", "resort_id" => "1"}}
    end

    describe "POST create" do
      it "instantiates a new airport distance with the given params" do
        expect(AirportDistance).to receive(:new).with(post_params[:airport_distance])
          .and_return(airport_distance)
        post "create", params: post_params
      end

      context "when the airport distance saves" do
        before do
          allow(AirportDistance).to receive(:new).and_return(airport_distance)
          allow(airport_distance).to receive(:save).and_return(true)
        end

        it "redirects to index" do
          post "create", params: post_params
          expect(response).to redirect_to(action: "index")
        end

        it "sets a notice" do
          post "create", params: post_params
          expect(flash[:notice]).to eq I18n.t("notices.created")
        end
      end
    end

    describe "GET edit" do
      it "finds the airport distance" do
        should_find_airport_distance
        get "edit", params: {"id" => "1"}
      end
    end

    def should_find_airport_distance
      expect(AirportDistance).to receive(:find).and_return(airport_distance)
    end

    def put_params
      {"id" => "1", "airport_distance" => {"distance_km" => "90"}}
    end

    describe "PUT update" do
      it "finds the airport distance" do
        should_find_airport_distance
        put "update", params: put_params
      end

      it "updates the airport distance" do
        allow(AirportDistance).to receive(:find).and_return(airport_distance)
        expect(airport_distance).to receive(:update_attributes).with(put_params["airport_distance"])
        put "update", params: put_params
      end

      context "when the airport distance saves" do
        before do
          allow(AirportDistance).to receive(:find).and_return(airport_distance)
          allow(airport_distance).to receive(:update_attributes).and_return(true)
        end

        it "redirects to index" do
          put "update", params: put_params
          expect(response).to redirect_to(action: "index")
        end

        it "sets a notice" do
          put "update", params: put_params
          expect(flash[:notice]).to eq I18n.t("notices.saved")
        end
      end

      context "when the airport distance fails to save" do
        before do
          allow(AirportDistance).to receive(:find).and_return(airport_distance)
          allow(airport_distance).to receive(:update_attributes).and_return(false)
        end
      end
    end
  end
end
