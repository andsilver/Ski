# frozen_string_literal: true

require "csv"
require "open-uri"

class Currency < ActiveRecord::Base
  #  Associations.
  has_many :trip_advisor_properties, dependent: :destroy

  # Validations.
  validates_uniqueness_of :code

  def to_s
    code
  end

  # Returns the value of one pound sterling in euros at the current exchange
  # rate, or nil if the data is missing.
  def self.sterling_in_euros
    find_by(code: "GBP").try(:in_euros)
  end

  # It returns the euro currency.
  def self.euro
    Currency.find_by(code: "EUR")
  end

  def self.gbp
    Currency.find_by(code: "GBP")
  end

  def self.update_exchange_rates
    currencies = Currency.all
    return if currencies.empty?
  end

  def self.exchange_rates_url
  end
end
