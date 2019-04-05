require "rails_helper"

module Admin
  RSpec.describe BuyingGuidesController, type: :controller do
    let(:website) { double(Website).as_null_object }
    let(:buying_guide) { double(BuyingGuide).as_null_object }

    before do
      allow(Website).to receive(:first).and_return(website)
      allow(controller).to receive(:admin?).and_return(true)
    end

    describe "PATCH update" do
      context "when buying guide found" do
        before { allow(BuyingGuide).to receive(:find_by).and_return(buying_guide) }

        context "when update succeeds" do
          before { allow(buying_guide).to receive(:update_attributes).and_return(true) }

          it "redirects to the edit action" do
            patch "update", params: {id: "1", buying_guide: {"some" => "params"}}
            expect(response).to redirect_to edit_admin_buying_guide_path(buying_guide)
          end
        end
      end
    end
  end
end
