require 'spec_helper'

describe Country do
  describe "scope :with_resorts" do
    before do
      # create countries and resorts such that at
      # least one country has resorts and at least
      # one country has no resorts
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
        Country.create!(:name => "Country #{x+1}", :id => x+1)
      end
    end

    def create_3_resorts
      3.times do |x|
        Resort.create!(:name => "Resort #{x+1}", :country_id => 1+rand(4))
      end
    end
  end
end
