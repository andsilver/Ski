# frozen_string_literal: true

require "rails_helper"
require_relative "shared_model_examples"

RSpec.describe Resort, type: :model do
  describe "associations" do
    it { should have_many(:interhome_place_resorts) }
    it { should respond_to(:summer_only?) }
    it { should have_many(:trip_advisor_locations).dependent(:nullify) }
  end

  before do
    # Accommodate leaky fixtures
    HolidayType.destroy_all
  end

  it_behaves_like "a flat namespace slug validator", :resort

  describe "#to_param" do
    it "returns its slug" do
      expect(Resort.new(slug: "slug").to_param).to eq "slug"
    end
  end

  describe "#to_s" do
    it "returns its name" do
      expect(Resort.new(name: "Chamonix").to_s).to eq "Chamonix"
    end
  end

  describe "#has_page?" do
    it "returns true if the page exists" do
      r = Resort.new
      allow(r).to receive(:page).and_return(Page.new)
      expect(r.has_page?("a-page")).to be_truthy
    end

    it "returns false if the page does not exist" do
      r = Resort.new
      allow(r).to receive(:page).and_return(nil)
      expect(r.has_page?("a-page")).to be_falsey
    end
  end

  describe "#page" do
    it "finds the page with the corresponding path" do
      r = Resort.new
      expect(r).to receive(:page_path).with("a-page").and_return("/path/to/a-page")
      expect(Page).to receive(:find_by).with(path: "/path/to/a-page")
      r.page("a-page")
    end
  end

  describe "#page_path" do
    it "returns the corresponding page path" do
      r = Resort.new(slug: "a-resort")
      expect(r.page_path("a-page")).to eq "/resorts/a-resort/a-page"
    end
  end

  describe "#handle_slug_change" do
    it "updates the paths of affected pages" do
      slug_pre = "pre"
      slug_post = "post"
      r = FactoryBot.create(:resort, slug: slug_pre)
      r.create_page("summer-holidays")
      r.slug = slug_post
      r.save
      summer_holidays = r.page("summer-holidays")
      expect(summer_holidays).to be
      expect(summer_holidays.path).to match(slug_post)
    end
  end

  describe "#ski?" do
    it "returns false when it has no ski-holidays holiday type" do
      expect(resort_with_holiday_type("city-breaks").ski?).to be_falsey
    end

    it "returns true when it has a ski-holidays holiday type" do
      expect(resort_with_holiday_type("ski-holidays").ski?).to be_truthy
    end

    def resort_with_holiday_type(slug)
      r = FactoryBot.create(:resort)
      ht = HolidayType.create!(name: "X", slug: slug)
      r.holiday_type_brochures.build(holiday_type: ht)
      r.save
      r
    end
  end
end
