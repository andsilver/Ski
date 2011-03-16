require 'spec_helper'

describe Country do
  describe "scope :with_resorts" do
    before do
      # create countries and resorts such that at
      # least one country has resorts and at least
      # one country has no resorts
      @country_ids = Array.new
      create_4_countries
      create_3_resorts
    end

    it "only returns countries that have resorts" do
      Country.with_resorts.should_not be_empty
      Country.with_resorts.each do |country|
        country.resorts.should_not be_empty
      end
    end

    it "returns all countries that have resorts" do
      Country.all.each do |country|
        Country.with_resorts.should include(country) unless country.resorts.empty?
      end
    end

    def create_4_countries
      4.times do |x|
        c = Country.create!(:name => "Country #{x+1}", :iso_3166_1_alpha_2 => "#{x+1}")
        @country_ids << c.id
      end
    end

    def create_3_resorts
      3.times do |x|
        r = Resort.create!(:name => "Resort #{x+1}", :country_id => @country_ids[rand(4)])
      end
    end
  end
end
