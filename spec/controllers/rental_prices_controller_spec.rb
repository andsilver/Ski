require "rails_helper"

RSpec.describe RentalPricesController, type: :controller do
  let(:website) { double(Website).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
  end

  describe "GET results" do
    context "when params[:rental_prices_search] is missing" do
      it "redirects to index" do
        get "results"
        expect(response).to redirect_to(action: "index")
      end
    end
  end
end
