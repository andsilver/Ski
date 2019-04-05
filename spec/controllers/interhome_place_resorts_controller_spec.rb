require "rails_helper"

RSpec.describe InterhomePlaceResortsController, type: :controller do
  let(:website) { double(Website).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
  end

  context "when signed in as admin" do
    before do
      allow(controller).to receive(:admin?).and_return(true)
    end

    describe "POST create" do
      let(:resort) { FactoryBot.create(:resort) }
      let(:interhome_place_resort) { double(InterhomePlaceResort).as_null_object }
      let(:params) { {interhome_place_resort: {"interhome_place_code" => "AD_1_1450", "resort_id" => resort.id.to_s}} }

      before do
        allow(InterhomePlaceResort).to receive(:new).and_return(interhome_place_resort)
      end

      it "instantiates a new Interhome place resort with the given params" do
        expect(InterhomePlaceResort).to receive(:new).with(params[:interhome_place_resort])
        post :create, params: params
      end

      it "redirects to the edit resort page" do
        post :create, params: params
        expect(response).to redirect_to(edit_admin_resort_path(resort))
      end

      context "when the Interhome place resort saves successfully" do
        before do
          allow(interhome_place_resort).to receive(:save).and_return(true)
        end

        it "sets a flash[:notice] message" do
          post "create", params: params
          expect(flash[:notice]).to eq("Created.")
        end
      end

      context "when the Interhome place resort fails to save" do
        before do
          allow(interhome_place_resort).to receive(:save).and_return(false)
        end

        it "sets a flash[:notice] message" do
          post "create", params: params
          expect(flash[:notice]).to eq("Could not link that Interhome place to this resort.")
        end
      end
    end

    describe "DELETE destroy" do
      let(:interhome_place_resort) { double(InterhomePlaceResort).as_null_object }

      before do
        allow(InterhomePlaceResort).to receive(:find).and_return(interhome_place_resort)
        allow(interhome_place_resort).to receive(:resort_id).and_return("2")
      end

      it "finds the Interhome place resort" do
        expect(InterhomePlaceResort).to receive(:find).with("1")
        delete "destroy", params: {id: "1"}
      end

      it "destroys the Interhome place resort" do
        expect(interhome_place_resort).to receive(:destroy)
        delete "destroy", params: {id: "1"}
      end

      it "redirects to the edit resort page" do
        delete "destroy", params: {id: "1"}
        expect(response).to redirect_to(edit_admin_resort_path(id: "2"))
      end

      it "sets a flash[:notice] message" do
        delete "destroy", params: {id: "1"}
        expect(flash[:notice]).to eq("Unlinked.")
      end
    end
  end
end
