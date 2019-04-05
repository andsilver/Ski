require "rails_helper"

module Admin
  RSpec.describe RegionsController, type: :controller do
    let(:website) { double(Website).as_null_object }

    before do
      allow(Website).to receive(:first).and_return(website)
    end

    context "as admin" do
      before { signed_in_as_admin }

      describe "PATCH update" do
        let(:region) { FactoryBot.create(:region) }

        context "when update succeeds" do
          before do
            allow(region).to receive(:update_attributes).and_return(true)
          end

          it "redirects to edit" do
            patch :update, params: {id: region.slug, region: {name: SecureRandom.hex}}
            expect(response).to redirect_to edit_admin_region_path(region)
          end
        end
      end
    end
  end
end
