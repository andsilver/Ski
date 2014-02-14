require 'spec_helper'

describe Admin::RegionsController do
  let(:website) { mock_model(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

  context 'as admin' do
    before { signed_in_as_admin }

    describe 'PATCH update' do
      let(:region) { FactoryGirl.create(:region) }

      context 'when update succeeds' do
        before do
          region.stub(:update_attributes).and_return(true)
        end

        it 'redirects to edit' do
          patch :update, id: region.slug, region: { name: SecureRandom.hex }
          expect(response).to redirect_to edit_admin_region_path(region)
        end
      end
    end
  end
end
