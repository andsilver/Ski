# frozen_string_literal: true

require "rails_helper"

RSpec.describe LongTermAdvert do
  describe "#initialize" do
    let(:user) { User.new }
    let(:prop) { FactoryBot.build(:property, user: user) }
    let(:advert) { @object.advert }
    before do
      @object = LongTermAdvert.new(prop)
    end

    it "instantiates a new advert" do
      expect(advert).to be_instance_of(Advert)
      expect(advert.new_record?).to be_truthy
    end

    it "sets the advert's property" do
      expect(advert.property).to eq prop
    end

    it "sets the user to the property's user" do
      expect(advert.user).to eq user
    end

    it "sets the advert starts_at time" do
      expect(advert.starts_at).to be <= Time.current
    end

    it "sets the advert expires_at time far into the future" do
      expect(advert.expires_at).to be > (Time.current + 10.years - 2.seconds)
    end

    it "sets the advert months to 120" do
      expect(advert.months).to eq 120
    end
  end

  describe "#create" do
    it "persists the new advert" do
      @object = LongTermAdvert.new(FactoryBot.create(:property))
      @object.create
      expect(@object.advert).to be_persisted
    end
  end
end
