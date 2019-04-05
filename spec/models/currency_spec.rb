# frozen_string_literal: true

require "rails_helper"

RSpec.describe Currency, type: :model do
  describe "associations" do
    it { should have_many(:trip_advisor_properties).dependent(:destroy) }
  end

  describe "#to_s" do
    it "returns its code" do
      currency = Currency.new(code: "GBP")
      expect(currency.to_s).to eq "GBP"
    end
  end

  describe ".sterling_in_euros" do
    context "when GBP currency exists" do
      before { FactoryBot.create(:currency, code: "GBP", in_euros: 1.5) }

      it "returns the amount of GBP in Euros" do
        expect(Currency.sterling_in_euros).to eq 1.5
      end
    end

    context "when GBP currency is missing" do
      it "returns nil" do
        expect(Currency.sterling_in_euros).to be_nil
      end
    end
  end

  describe ".euro" do
    it "returns the currency whose code is EUR" do
      euro = FactoryBot.create(:currency, code: "EUR")
      expect(Currency.euro).to eq euro
    end
  end

  describe ".update_exchange_rates" do
    skip "need a new data provider"
  end

  describe ".exchange_rates_url" do
  end
end
