module LateAvailability
  class Finder
    def find_featured(opts = {})
      Property.where(late_availability: true).order('RAND()').limit(opts[:limit])
    end
  end
end
