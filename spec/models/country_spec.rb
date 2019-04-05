# frozen_string_literal: true

require "rails_helper"

RSpec.describe Country, type: :model do
  describe "scope :with_resorts" do
    before do
      # create countries and resorts such that at
      # least one country has resorts and at least
      # one country has no resorts
      @country_ids = []
      create_4_countries
      create_3_resorts
    end

    it "only returns countries that have resorts" do
      expect(Country.with_resorts).not_to be_empty
      Country.with_resorts.each do |country|
        expect(country.resorts).not_to be_empty
      end
    end

    it "returns all countries that have resorts" do
      Country.all.each do |country|
        expect(Country.with_resorts).to include(country) unless country.resorts.empty?
      end
    end

    def create_4_countries
      4.times do |x|
        c = Country.create!(name: "Country #{x + 1}", iso_3166_1_alpha_2: (x + 1).to_s, slug: "country-#{x + 1}")
        @country_ids << c.id
      end
    end

    def create_3_resorts
      3.times do |x|
        Resort.create!(name: "Resort #{x + 1}", country_id: @country_ids[rand(4)], slug: "resort-#{x + 1}")
      end
    end
  end

  describe "#to_param" do
    it "returns its slug" do
      expect(Country.new(slug: "slug").to_param).to eq "slug"
    end
  end

  describe ".page_names" do
    it "returns an array of HolidayType slugs" do
      HolidayType.delete_all
      FactoryBot.create(:holiday_type, slug: "page-1")
      FactoryBot.create(:holiday_type, slug: "page-2")
      expect(Country.page_names).to eq ["page-1", "page-2"]
    end
  end

  describe "#region_brochures" do
    let(:ht) { FactoryBot.create(:holiday_type) }
    let(:country) { FactoryBot.create(:country) }

    it "returns brochures for child regions with specified holiday type" do
      region = FactoryBot.create(:region, country: country)
      country.holiday_type_brochures.build(holiday_type: ht)
      region_brochure = region.holiday_type_brochures.build(holiday_type: ht)
      country.save
      region.save

      expect(country.region_brochures(ht.id).to_a).to eq [region_brochure]
    end

    it "excludes invisible resorts" do
      region = FactoryBot.create(:region, country: country, visible: false)
      country.holiday_type_brochures.build(holiday_type: ht)
      region.holiday_type_brochures.build(holiday_type: ht)
      country.save
      region.save

      expect(country.region_brochures(ht.id).to_a).to eq []
    end
  end

  describe "#themes" do
    it "returns an array of slugs for each associated holiday type" do
      country = FactoryBot.create(:country)
      FactoryBot.create(:holiday_type, slug: "city")
      lakes = FactoryBot.create(:holiday_type, slug: "lakes")
      ski = FactoryBot.create(:holiday_type, slug: "ski")
      country.holiday_type_brochures.build(holiday_type: lakes)
      country.holiday_type_brochures.build(holiday_type: ski)
      country.save

      expect(country.themes).not_to include("city")
      expect(country.themes).to include("lakes")
      expect(country.themes).to include("ski")
    end
  end
end
