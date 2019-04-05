require "rails_helper"

module Admin
  RSpec.describe CurrenciesController, type: :controller do
    let(:website) { double(Website).as_null_object }

    before do
      allow(Website).to receive(:first).and_return(website)
    end

    def mock_currency(stubs = {})
      @mock_currency ||= double(Currency, stubs)
    end

    context "when signed in as admin" do
      before { signed_in_as_admin }

      describe "POST create" do
        context "on successful save" do
          before { allow(Currency).to receive(:new).and_return(mock_currency(save: true)) }

          it "redirects to admin currencies path" do
            post "create", params: {id: "1", currency: {"some" => "params"}}
            expect(response).to redirect_to admin_currencies_path
          end
        end
      end

      describe "PATCH update" do
        context "on successful update" do
          before { allow(Currency).to receive(:find).and_return(mock_currency(update_attributes: true)) }

          it "redirects to admin currencies path" do
            patch "update", params: {id: "1", currency: {"some" => "params"}}
            expect(response).to redirect_to admin_currencies_path
          end
        end
      end

      describe "GET update_exchange_rates" do
        it "updates exchange rates" do
          expect(Currency).to receive(:update_exchange_rates)
          get "update_exchange_rates"
        end

        it "redirects to admin currencies path" do
          get "update_exchange_rates"
          expect(response).to redirect_to admin_currencies_path
        end
      end
    end
  end
end
