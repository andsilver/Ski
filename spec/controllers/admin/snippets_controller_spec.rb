require "rails_helper"

module Admin
  RSpec.describe SnippetsController, type: :controller do
    let(:website) { double(Website).as_null_object }

    def mock_snippet(stubs = {})
      @mock_snippet ||= double(Snippet, stubs)
    end

    before do
      allow(Website).to receive(:first).and_return(website)
    end

    context "when signed in as admin" do
      before { signed_in_as_admin }

      describe "GET index" do
        it "finds all snippets ordered by name" do
          expect(Snippet).to receive(:order).with("name")
          get "index"
        end
      end

      describe "POST create" do
        context "on successful save" do
          before { allow(Snippet).to receive(:new).and_return(mock_snippet(save: true)) }

          it "redirects to admin snippets path" do
            post "create", params: {id: "1", snippet: {"some" => "params"}}
            expect(response).to redirect_to admin_snippets_path
          end
        end
      end

      describe "PATCH update" do
        context "on successful update" do
          before { allow(Snippet).to receive(:find).and_return(mock_snippet(update_attributes: true)) }

          it "redirects to admin snippets path" do
            patch "update", params: {id: "1", snippet: {"some" => "params"}}
            expect(response).to redirect_to admin_snippets_path
          end
        end
      end

      describe "DELETE destroy" do
        context "when snippet found" do
          before { allow(Snippet).to receive(:find).and_return(mock_snippet) }

          it "destroys the snippet" do
            expect(mock_snippet).to receive(:destroy)
            delete "destroy", params: {id: "1"}
          end

          it "redirects to admin snippets path" do
            allow(mock_snippet).to receive(:destroy)
            delete "destroy", params: {id: "1"}
            expect(response).to redirect_to admin_snippets_path
          end
        end
      end
    end
  end
end
