require "rails_helper"

RSpec.describe CategoriesController, type: :controller do
  let(:website) { double(Website).as_null_object }
  let(:category) { double(Category).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
    allow(Category).to receive(:new).and_return(category)
    allow(controller).to receive(:admin?).and_return(true)
  end

  describe "GET show" do
    let(:cat)    { FactoryBot.create(:category) }
    let(:resort) { FactoryBot.create(:resort) }

    context "with results" do
      before do
        allow(Category).to receive(:new).and_call_original
        da = FactoryBot.create(:directory_advert, category: cat, resort: resort)
        Advert.new_for(da).start_and_save!
      end

      it "succeeds" do
        get :show, params: {id: cat.id, resort_slug: resort.to_param}
        expect(response).to be_successful
      end
    end

    context "with no results" do
      it "404s" do
        allow(Category).to receive(:new).and_call_original
        get :show, params: {id: cat.id, resort_slug: resort.to_param}
        expect(response.status).to eq 404
      end
    end
  end
end
