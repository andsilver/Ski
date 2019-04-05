require "rails_helper"

module Admin
  RSpec.describe FootersController, type: :controller do
    let(:website) { double(Website).as_null_object }

    def mock_footer(stubs = {})
      @mock_footer ||= double(Footer, stubs)
    end

    before do
      allow(Website).to receive(:first).and_return(website)
    end

    context "when signed in as admin" do
      before { signed_in_as_admin }

      describe "GET index" do
        before { allow(controller).to receive(:use_default_footer) }

        it "finds all footers" do
          expect(Footer).to receive(:all)
          get "index"
        end
      end

      describe "POST create" do
        context "on successful save" do
          before { allow(Footer).to receive(:new).and_return(mock_footer(save: true)) }

          it "redirects to admin footers path" do
            post "create", params: {id: "1", footer: {"some" => "params"}}
            expect(response).to redirect_to admin_footers_path
          end
        end
      end

      describe "PATCH update" do
        context "on successful update" do
          before { allow(Footer).to receive(:find).and_return(mock_footer(update_attributes: true)) }

          it "redirects to admin footers path" do
            patch "update", params: {id: "1", footer: {"some" => "params"}}
            expect(response).to redirect_to admin_footers_path
          end
        end
      end

      describe "DELETE destroy" do
        context "when footer found" do
          before { allow(Footer).to receive(:find).and_return(mock_footer) }

          it "destroys the footer" do
            expect(mock_footer).to receive(:destroy)
            delete "destroy", params: {id: "1"}
          end

          it "redirects to admin footers path" do
            allow(mock_footer).to receive(:destroy)
            delete "destroy", params: {id: "1"}
            expect(response).to redirect_to admin_footers_path
          end
        end
      end
    end
  end
end
