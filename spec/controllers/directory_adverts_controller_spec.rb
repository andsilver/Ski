require "rails_helper"

RSpec.describe DirectoryAdvertsController, type: :controller do
  let(:website) { double(Website).as_null_object }
  let(:current_user) { FactoryBot.create(:user) }

  before do
    allow(Website).to receive(:first).and_return(website)
    allow(controller).to receive(:signed_in?).and_return(true)
    allow(controller).to receive(:current_user).and_return(current_user)
  end

  describe "GET index" do
    before do
      allow(controller).to receive(:admin?).and_return(true)
    end

    it "finds all directory adverts" do
      expect(DirectoryAdvert).to receive(:all)
      get "index"
    end
  end

  describe "GET new" do
    let(:directory_advert) { double(DirectoryAdvert).as_null_object }

    before do
      allow(DirectoryAdvert).to receive(:new).and_return(directory_advert)
    end

    it "instantiates a new directory advert" do
      expect(DirectoryAdvert).to receive(:new)
      get "new"
    end
  end

  describe "GET show" do
    let(:directory_advert) { double(DirectoryAdvert).as_null_object }

    it "finds a directory advert specified by param[:id]" do
      expect(DirectoryAdvert).to receive(:find_by).with(id: "1")
      get "show", params: {id: "1"}
    end

    context "when the advert is found" do
      let(:advert) { double(Advert).as_null_object }
      let(:category) { double(Category).as_null_object }
      let(:resort) { double(Resort).as_null_object }
      let(:country) { double(Country).as_null_object }

      before do
        allow(DirectoryAdvert).to receive(:find_by).and_return(directory_advert)
        allow(directory_advert).to receive(:category).and_return(category)
        allow(directory_advert).to receive(:resort).and_return(resort)
        allow(resort).to receive(:country).and_return(country)
      end

      it "sets the default page title" do
        allow(directory_advert).to receive(:business_name).and_return("Monkey Bar")
        allow(category).to receive(:name).and_return("bars")
        allow(resort).to receive(:name).and_return("Chamonix")
        allow(country).to receive(:name).and_return("France")
        expect(controller).to receive(:default_page_title).with(anything)
        get "show", params: {id: 1}
      end

      context "with a current advert" do
        before { allow(directory_advert).to receive(:current_advert).and_return(advert) }

        it "records a view" do
          expect(advert).to receive(:record_view)
          get "show", params: {id: 1}
        end
      end

      context "without a current advert" do
        before { allow(directory_advert).to receive(:current_advert).and_return(nil) }

        it "does not try and record a view" do
          get "show", params: {id: "1"}
        end
      end
    end

    context "when the advert is not found" do
      before do
        allow(DirectoryAdvert).to receive(:find_by).and_return(nil)
      end

      it "renders not found" do
        get "show", params: {id: 1}
        expect(response.status).to eql 404
      end
    end
  end

  describe "POST create" do
    let(:directory_advert) { double(DirectoryAdvert).as_null_object }

    before do
      allow(DirectoryAdvert).to receive(:new).and_return(directory_advert)
      allow(directory_advert).to receive(:default_months).and_return(12)
      allow(directory_advert).to receive(:user_id).and_return(current_user.id)
      allow(Advert)
        .to receive(:new_for)
        .with(directory_advert)
        .and_return(Advert.new(user_id: current_user.id))
    end

    def post_valid
      post(
        "create", params: {
          directory_advert: {
            category_id: "1", business_address: "123 av", resort_id: ["1"],
          },
        }
      )
    end

    it "instantiates a new directory advert" do
      expect(DirectoryAdvert)
        .to receive(:new)
        .with({"category_id" => "1", "business_address" => "123 av"})
        .and_return(directory_advert)
      post_valid
    end

    it "associates the advert with the current user" do
      expect(directory_advert).to receive(:user_id=).with(current_user.id)
      post_valid
    end

    context "when the directory advert saves successfully" do
      before do
        allow(directory_advert).to receive(:save).and_return(true)
      end

      it "sets a flash[:notice] message" do
        post_valid
        expect(flash[:notice]).to eq("Your directory advert was successfully created.")
      end

      it "redirects to the basket" do
        post_valid
        expect(response).to redirect_to(basket_path)
      end
    end
  end

  describe "DELETE destroy" do
    let(:directory_advert) { double(DirectoryAdvert).as_null_object }

    before do
      allow(DirectoryAdvert).to receive(:find).and_return(directory_advert)
    end

    it "finds a directory advert specified by param[:id]" do
      expect(DirectoryAdvert).to receive(:find).with("1")
      delete :destroy, params: {id: "1"}
    end

    context "when not owned or admin" do
      before { expect(controller).to receive(:owned_or_admin?).with(directory_advert).and_return(false) }

      it "responds with 404" do
        delete :destroy, params: {id: "1"}
        expect(response.status).to eq 404
      end
    end

    context "when owned or admin" do
      before { expect(controller).to receive(:owned_or_admin?).with(directory_advert).and_return(true) }

      it "destroys a directory advert" do
        expect(directory_advert).to receive(:destroy)
        delete :destroy, params: {id: "1"}
      end

      context "when admin" do
        before { allow(controller).to receive(:admin?).and_return(true) }

        it "redirects to directory adverts page" do
          delete :destroy, params: {id: "1"}
          expect(response).to redirect_to(directory_adverts_path)
        end
      end

      context "when not admin" do
        before { allow(controller).to receive(:admin?).and_return(false) }

        it "redirects to My Adverts" do
          delete :destroy, params: {id: "1"}
          expect(response).to redirect_to(my_adverts_path)
        end
      end
    end
  end

  describe "POST click" do
    let(:directory_advert) { FactoryBot.create(:directory_advert, url: "http://example.org") }

    it "redirects to the directory advert remote URL" do
      post :click, params: {id: directory_advert.id}
      expect(response).to redirect_to directory_advert.url
    end

    context "when user agent is not a bot" do
      before { allow(controller).to receive(:bot?).and_return(false) }

      it "tracks a click action" do
        expect(TrackedAction).to receive(:create).with(hash_including(
          action_type: :click,
          http_user_agent: request.env["HTTP_USER_AGENT"],
          remote_ip: request.remote_ip,
          trackable_id: directory_advert.id,
          trackable_type: "DirectoryAdvert"
        ))
        post :click, params: {id: directory_advert.id}
      end
    end

    context "when user agent is a bot" do
      before { allow(controller).to receive(:bot?).and_return(true) }

      it "does not track a click action" do
        expect(TrackedAction).not_to receive(:create)
        post :click, params: {id: directory_advert.id}
      end
    end
  end
end
