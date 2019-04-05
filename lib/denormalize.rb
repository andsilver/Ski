# frozen_string_literal: true

class Denormalize
  def self.denormalize
    update_featured_properties

    Currency.update_exchange_rates

    update_properties

    update_resorts

    update_countries

    update_regions
  end

  def self.count_properties(resort, attribute, value)
    Property.where(:resort_id => resort.id, :publicly_visible => true, attribute => value).count
  end

  def self.update_featured_properties
    if (website = Website.first)
      website.featured_properties = Property.featured
      website.save
    end
  end

  def self.update_properties
    Property.stop_geocoding
    Property.includes(:resort).find_in_batches(batch_size: 250) do |properties|
      properties.each do |p|
        publicly_visible = p.currently_advertised? && p.resort.visible?
        p.publicly_visible = publicly_visible
        p.set_country_and_region
        p.normalise_prices
        p.late_availability = p.calculate_late_availability(LateAvailability.next_three_saturdays)
        p.save
      end
      sleep(0.5)
    end
    Property.resume_geocoding
  end

  def self.update_resorts
    Resort.visible.each do |resort|
      resort.for_rent_count = count_properties(resort, :listing_type, Property::LISTING_TYPE_FOR_RENT)
      resort.for_sale_count = count_properties(resort, :listing_type, Property::LISTING_TYPE_FOR_SALE)
      resort.new_development_count = count_properties(resort, :new_development, true)
      resort.property_count = resort.for_rent_count + resort.for_sale_count +
        resort.new_development_count

      conditions = DirectoryAdvert::CURRENTLY_ADVERTISED.dup
      conditions[0] += " AND resort_id = ?"
      conditions << resort.id
      resort.directory_advert_count = DirectoryAdvert.where(conditions).count

      resort.save
    end
  end

  def self.update_countries
    Country.with_visible_resorts.each do |country|
      country.property_count = country.visible_resorts.inject(0) {|c, r| c + r.property_count}
      country.save
    end
  end

  def self.update_regions
    Region.all.each do |region|
      region.property_count = region.visible_resorts.inject(0) {|sum, r| sum + r.property_count}
      region.save
    end
  end

  def self.cache_availability
    dates = []
    (18 * 30).times do |d|
      dates << Date.today + d.days
    end

    Property.stop_geocoding
    Property.find_in_batches(batch_size: 25) do |properties|
      properties.each { |p| p.cache_availability(dates) }
      sleep(1)
    end
    Property.resume_geocoding

    Availability.delete_past
  end

  def self.generate_thumbnails
    Property.stop_geocoding
    Property.find_in_batches(batch_size: 25) do |properties|
      properties.each do |property|
        # TODO: Use helper methods do DRY.
        # property_image_thumbnail(property)
        if property.image
          # Thumbnail on listing page.
          property.image.sized_url(165, :height)
          # Featured property.
          property.image.url(258)
        end
        property.images.each do |image|
          # Thumbnail for properties/show.html.erb and
          # properties/show_interhome.html.erb.
          image.sized_url(135, :height)
          # Thumbnail for new developments.
          image.sized_url(99, :square)
        end
      end
      sleep(1)
    end
    Property.resume_geocoding
  end
end
