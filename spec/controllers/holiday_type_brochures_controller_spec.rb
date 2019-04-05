require "rails_helper"

RSpec.describe HolidayTypeBrochuresController, type: :controller do
  let(:website) { double(Website).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
  end

  describe "GET show" do
    context "with invalid place and holiday type" do
      it "404s" do
        get :show, params: {place_type: "resorts", place_slug: "nowhere", holiday_type_slug: "none"}
        expect(response.status).to eq 404
      end
    end

    context "with valid place and invalid holiday type" do
      let(:resort) { FactoryBot.create(:resort) }

      it "404s" do
        get :show, params: {place_type: "resorts", place_slug: resort.slug, holiday_type_slug: "none"}
        expect(response.status).to eq 404
      end
    end

    context "with invalid place and valid holiday type" do
      let(:holiday_type) { FactoryBot.create(:holiday_type) }

      it "404s" do
        get :show, params: {place_type: "resorts", place_slug: "nowhere", holiday_type_slug: holiday_type.slug}
        expect(response.status).to eq 404
      end
    end

    context "with valid place and holiday type" do
      let(:resort) { FactoryBot.create(:resort) }
      let(:holiday_type) { FactoryBot.create(:holiday_type) }

      context "with holiday type brochure" do
        before do
          brochure = resort.holiday_type_brochures.build(holiday_type_id: holiday_type.id)
          brochure.save
        end

        it "renders" do
          get :show, params: {place_type: "resorts", place_slug: resort.slug, holiday_type_slug: holiday_type.slug}
          expect(response.status).to eq 200
        end
      end

      context "without holiday type brochure" do
        it "404s" do
          get :show, params: {place_type: "resorts", place_slug: resort.slug, holiday_type_slug: holiday_type.slug}
          expect(response.status).to eq 404
        end
      end
    end
  end
end
