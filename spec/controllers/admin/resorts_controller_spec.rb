require "rails_helper"

module Admin
  RSpec.describe ResortsController, type: :controller do
    let(:website) { double(Website).as_null_object }
    let(:resort) { double(Resort, id: 1).as_null_object }

    before do
      allow(Website).to receive(:first).and_return(website)
      allow(controller).to receive(:admin?).and_return(true)
    end

    describe "GET index" do
      let(:countries) { double(Array) }

      before do
        allow(Country).to receive(:with_resorts).and_return(countries)
      end

      it "finds all countries with resorts" do
        expect(Country).to receive(:with_resorts)
        get :index
      end
    end

    describe "POST create" do
      let(:resort) { double(Resort).as_null_object }
      let(:params) { {resort: {"name" => "Morzine"}} }

      before do
        allow(Resort).to receive(:new).and_return(resort)
      end

      it "instantiates a new resort with the given params" do
        expect(Resort).to receive(:new).with(params[:resort])
        post "create", params: params
      end

      context "when the resort saves successfully" do
        before do
          allow(resort).to receive(:save).and_return(true)
        end

        it "sets a flash[:notice] message" do
          post "create", params: params
          expect(flash[:notice]).to eq("Created.")
        end

        it "redirects to the resorts page" do
          post "create", params: params
          expect(response).to redirect_to(admin_resorts_path)
        end
      end
    end

    describe "GET edit" do
      let(:interhome_place_resort) { InterhomePlaceResort.new }

      it "finds a resort" do
        expect(Resort).to receive(:find_by).with(slug: "chamonix")
        get "edit", params: {id: "chamonix"}
      end

      context "when resort is found" do
        before do
          allow(Resort).to receive(:find_by).and_return(resort)
        end

        it "creates a new Interhome place resort and sets its resort_id" do
          expect(InterhomePlaceResort).to receive(:new).with(resort_id: resort.id)
          get "edit", params: {id: "1"}
        end
      end
    end

    describe "DELETE destroy" do
      context "when resort found" do
        before do
          allow(Resort).to receive(:find_by).and_return(resort)
        end

        context "when resort has no properties or directory adverts" do
          before do
            allow(resort).to receive_message_chain([:properties, :any?]).and_return(false)
            allow(resort).to receive_message_chain([:directory_adverts, :any?]).and_return(false)
          end

          it "destroys the resort" do
            expect(resort).to receive(:destroy)
            delete :destroy, params: {id: "chamonix"}
          end

          it "redirects to the resorts index" do
            delete :destroy, params: {id: "chamonix"}
            expect(response).to redirect_to(admin_resorts_path)
          end

          it "sets a flash notice" do
            delete :destroy, params: {id: "chamonix"}
            expect(flash[:notice]).to eq I18n.t("notices.deleted")
          end
        end
      end
    end

    describe "POST destroy_properties" do
      it "finds the resort" do
        expect(Resort).to receive(:find_by).with(slug: "chamonix").and_return(resort)
        post "destroy_properties", params: {id: "chamonix"}
      end

      context "when the resort is found" do
        before { allow(Resort).to receive(:find_by).and_return(resort) }

        it "destroys each property" do
          properties = double(ActiveRecord::Relation)
          allow(resort).to receive(:properties).and_return(properties)
          expect(properties).to receive(:destroy_all)
          post "destroy_properties", params: {id: "chamonix"}
        end

        it "redirects to the resorts index" do
          post "destroy_properties", params: {id: "chamonix"}
          expect(response).to redirect_to(admin_resorts_path)
        end

        it "sets a flash notice" do
          post "destroy_properties", params: {id: "chamonix"}
          expect(flash[:notice]).to eq("Properties deleted.")
        end
      end
    end

    describe "POST destroy_directory_adverts" do
      it "finds the resort" do
        expect(Resort).to receive(:find_by).with(slug: "chamonix").and_return(resort)
        post :destroy_directory_adverts, params: {id: "chamonix"}
      end

      context "when the resort is found" do
        before { allow(Resort).to receive(:find_by).and_return(resort) }

        it "destroys each directory advert" do
          directory_adverts = double(ActiveRecord::Relation)
          allow(resort).to receive(:directory_adverts).and_return(directory_adverts)
          expect(directory_adverts).to receive(:destroy_all)
          post :destroy_directory_adverts, params: {id: "chamonix"}
        end

        it "redirects to the resorts index" do
          post :destroy_directory_adverts, params: {id: "chamonix"}
          expect(response).to redirect_to(admin_resorts_path)
        end

        it "sets a flash notice" do
          post :destroy_directory_adverts, params: {id: "chamonix"}
          expect(flash[:notice]).to eq("Directory adverts deleted.")
        end
      end
    end
  end
end
