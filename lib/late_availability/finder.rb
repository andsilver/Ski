# frozen_string_literal: true

module LateAvailability
  class Finder
    def find_featured(opts = {})
      Property.where(late_availability: true)
        .order(Arel.sql("RAND()"))
        .limit(opts[:limit])
    end
  end
end
