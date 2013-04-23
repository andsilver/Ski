require 'csv'
require 'open-uri'

class Currency < ActiveRecord::Base
  validates_uniqueness_of :code

  def self.sterling_in_euros
    gbp = find_by_code('GBP')
    gbp ? gbp.in_euros : 0
  end

  def self.update_exchange_rates
    currencies = Currency.all
    return if currencies.empty?

    url = 'http://download.finance.yahoo.com/d/quotes.csv?f=sl1d1t1ba&e=.csv&s='
    search_terms = []
    currencies.each do |c|
      search_terms << "#{c.code}EUR=X"
    end
    url += search_terms.inject() { |r,e| r + "," + e }

    open(url) do |f|
      f.each_line do |line|
        @parsed = defined?(CSV::Reader) ? CSV::Reader.parse(line) : CSV.parse(line)
        @parsed.each do |row|
          code = row[0][0..2]
          currency = Currency.find_by_code(code)
          currency.in_euros = row[1]
          currency.save
        end
      end
    end
  end
end
