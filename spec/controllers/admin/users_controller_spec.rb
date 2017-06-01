require 'rails_helper'

describe Admin::UsersController do
  before do
    FactoryGirl.create(:website)
    FactoryGirl.create(:user)
    signed_in_as_admin
  end

  describe 'POST extend_windows' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:advert) { Advert.create(user: user, window: true, expires_at: '2015-01-01' )}

    it 'adds params[:days] to the expiry date of each window' do
      post :extend_windows, params: { id: user.id, days: 10 }
      expect(advert.reload.expires_at).to eq Time.parse('2015-01-11')
    end

    it 'redirects to /my/adverts for the user' do
      post :extend_windows, params: { id: user.id, days: 10 }
      expect(response).to redirect_to my_adverts_path(user_id: user.id)
    end
  end
end
