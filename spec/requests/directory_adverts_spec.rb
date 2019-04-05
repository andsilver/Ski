require "rails_helper"

RSpec.describe "Directory adverts", type: :request do
  before { FactoryBot.create(:website) }
  describe "GET /directory_adverts/:id" do
    let!(:ad) { FactoryBot.create(:directory_advert) }
    def perform
      get "/directory_adverts/#{ad.id}"
    end

    context "advert is currently advertised" do
      before do
        FactoryBot.create(
          :advert, directory_advert_id: ad.id, expires_at: Date.tomorrow
        )
      end

      it "responds 200" do
        perform
        expect(response.status).to eq 200
      end

      it "links to the category page" do
        perform
        assert_select(
          "a[href='/categories/#{ad.category.to_param}/#{ad.resort.slug}']"
        )
      end
    end
  end
end
