# frozen_string_literal: true

require "rails_helper"

RSpec.describe ResortsController do
  let(:website) { double(Website).as_null_object }
  let(:resort) { FactoryBot.create(:resort) }

  before do
    allow(Website).to receive(:first).and_return(website)
    allow(controller).to receive(:admin?).and_return(false)
  end

  shared_examples "a featured properties finder" do |action, params|
    before do
      allow(Resort)
        .to receive(:find_by)
        .and_return(double(Resort, visible: true).as_null_object)
    end

    it "assigns @featured_properties" do
      pending
      get action, params: params
      expect(assigns(:featured_properties)).to_not be_nil
    end
  end

  describe "GET show" do
    it_behaves_like "a featured properties finder", :show, id: "chamonix"

    it "finds a resort by its slug" do
      expect(Resort)
        .to receive(:find_by)
        .with(slug: "chamonix")
        .and_return(Resort.new)
      get :show, params: {id: "chamonix"}
    end

    context "when resort not found by slug" do
      before do
        allow(Resort).to receive(:find_by).with(slug: "chamonix").and_return nil
      end

      it "finds a resort by its ID" do
        expect(Resort).to receive(:find_by).with(id: "chamonix")
        get :show, params: {id: :chamonix}
      end

      context "when resort found by its ID" do
        before do
          expect(Resort)
            .to receive(:find_by)
            .with(id: "chamonix")
            .and_return resort
        end

        it "permanently redirects to that resort" do
          get :show, params: {id: "chamonix"}
          expect(response).to redirect_to resort
          expect(response.status).to eq 301
        end
      end
    end
  end

  describe "GET resort_guide" do
    it_behaves_like "a featured properties finder", :resort_guide,
      id: "chamonix"
  end

  describe "GET piste_map" do
    let(:resort) { FactoryBot.create(:resort) }

    before do
      allow(Resort).to receive(:find_by).and_return(resort)
      allow(resort).to receive(:has_piste_maps?).and_return(has_piste_maps)
      get :piste_map, params: {id: resort.to_param}
    end

    context "when resort doesn't have piste maps" do
      let(:has_piste_maps) { false }

      it "404s" do
        expect(response.status).to eq 404
      end
    end

    context "when resort has piste maps" do
      let(:has_piste_maps) { true }

      it "succeeds" do
        expect(response.status).to eq 200
      end
    end
  end

  describe "GET summer_holidays" do
    let(:resort) { FactoryBot.create(:resort) }
    let(:admin)  { false }

    before do
      allow(controller).to receive(:admin?).and_return admin
      allow(controller).to receive(:page_info).and_return page_info
      get :summer_holidays, params: {id: resort.to_param}
    end

    context "with no page" do
      let(:page_info) { nil }

      it "404s" do
        expect(response.status).to eq 404
      end
    end

    context "with invisible page" do
      let(:page_info) { Page.new(visible: false) }

      it "404s" do
        expect(response.status).to eq 404
      end

      context "when admin" do
        let(:admin) { true }

        it "renders" do
          expect(response).to be_successful
        end
      end
    end

    context "with visible page" do
      let(:page_info) { Page.new(visible: true) }

      it "renders" do
        expect(response).to be_successful
      end
    end
  end
end
