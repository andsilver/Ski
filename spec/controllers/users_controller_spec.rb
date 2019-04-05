require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:website) { double(Website).as_null_object }
  let(:user) { double(User).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
    allow(User).to receive(:new).and_return(user)
  end

  describe "PATCH update" do
    before do
      allow(controller).to receive(:current_user).and_return(user)
      allow(User).to receive(:find).with("1").and_return(user)
    end

    let(:update_params) {{id: "1", user: {"first_name" => "Fred"}}}

    context "when the user saves" do
      context "when admin" do
        before { signed_in_as_admin }

        it "redirects to admin users index" do
          patch :update, params: update_params
          expect(response).to redirect_to(admin_users_path)
        end

        it "sets a notice" do
          patch :update, params: update_params
          expect(flash.notice).to eq I18n.t("notices.saved")
        end
      end

      context "when user" do
        before do
          signed_in
          allow(controller).to receive(:admin?).and_return(false)
        end

        it "redirects to My Details" do
          patch :update, params: update_params
          expect(response).to redirect_to(my_details_path)
        end

        it "sets a notice" do
          patch :update, params: update_params
          expect(flash.notice).to eq I18n.t("my_details_saved")
        end
      end
    end
  end
end
