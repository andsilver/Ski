module LateAvailability
  class Finder
    def find_featured(opts = {})
      Property.where(late_availability: true).limit(opts[:limit])
    end
  end
end
