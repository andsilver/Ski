require 'spec_helper'

describe Admin::BuyingGuidesController do
  let(:website) { mock_model(Website).as_null_object }
  let(:buying_guide) { mock_model(BuyingGuide).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    controller.stub(:admin?).and_return(true)
  end

  describe 'PATCH update' do
    context 'when buying guide found' do
      before { BuyingGuide.stub(:find_by_id).and_return(buying_guide) }     

      context 'when update succeeds' do
        before { buying_guide.stub(:update_attributes).and_return(true) }

        it 'redirects to the edit action' do
          patch 'update', id: '1', buying_guide: { 'some' => 'params' }
          expect(response).to redirect_to edit_admin_buying_guide_path(buying_guide)
        end
      end
    end
  end
end
