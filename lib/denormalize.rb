class Denormalize
  def self.denormalize
    update_featured_properties

    Currency.update_exchange_rates

    Property.stop_geocoding
    Property.find_in_batches(batch_size: 250, include: [:resort]) do |properties|
      properties.each do |p|
        publicly_visible = p.currently_advertised? && p.resort.visible?
        country_id = p.resort.country_id
        p.publicly_visible = publicly_visible
        p.country_id = country_id
        p.normalise_prices
        p.late_availability = p.calculate_late_availability(LateAvailability.next_three_saturdays)
        p.cache_unavailability(dates)
        p.save
      end
      sleep(0.5)
    end
    Property.resume_geocoding

    Resort.visible.each do |resort|
      resort.for_rent_count = count_properties(resort, :listing_type, Property::LISTING_TYPE_FOR_RENT)
      resort.for_sale_count = count_properties(resort, :listing_type, Property::LISTING_TYPE_FOR_SALE)
      resort.hotel_count = count_properties(resort, :listing_type, Property::LISTING_TYPE_HOTEL)
      resort.new_development_count = count_properties(resort, :new_development, true)
      resort.property_count = resort.for_rent_count + resort.for_sale_count + resort.hotel_count + resort.new_development_count

      conditions = CategoriesController::CURRENTLY_ADVERTISED.dup
      conditions[0] += " AND resort_id = ?"
      conditions << resort.id
      resort.directory_advert_count = DirectoryAdvert.count(conditions: conditions)

      resort.save
    end

    Country.with_visible_resorts.each do |country|
      country.property_count = country.visible_resorts.inject(0) {|c, r| c + r.property_count}
      country.save
    end
  end

  def self.count_properties(resort, attribute, value)
    Property.where(resort_id: resort.id, publicly_visible: true, attribute => value).count
  end

  def self.update_featured_properties
    website = Website.first
    website.featured_properties = Property.featured
    website.save
  end

  def self.cache_unavailability
    start_time = Time.now

    dates = []
    (18 * 30).times do |d|
      dates << Date.today + d.days
    end

    Property.stop_geocoding
    Property.find_in_batches(batch_size: 25) do |properties|
      properties.each { |p| p.cache_unavailability(dates) }
      sleep(1)
    end
    Property.resume_geocoding

    Unavailability.where('created_at < ?', start_time).delete_all
  end
end
