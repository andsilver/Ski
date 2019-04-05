require "rails_helper"

module Admin
  RSpec.describe UsersController, type: :controller do
    before do
      FactoryBot.create(:website)
      FactoryBot.create(:user)
      signed_in_as_admin
    end

    describe "POST extend_windows" do
      let(:user) { FactoryBot.create(:user) }
      let!(:advert) do
        Advert.create(user: user, window_spot: true, expires_at: "2015-01-01")
      end

      it "adds params[:days] to the expiry date of each window" do
        post :extend_windows, params: {id: user.id, days: 10}
        expect(advert.reload.expires_at).to eq Time.parse("2015-01-11")
      end

      it "redirects to /my/adverts for the user" do
        post :extend_windows, params: {id: user.id, days: 10}
        expect(response).to redirect_to my_adverts_path(user_id: user.id)
      end
    end
  end
end
