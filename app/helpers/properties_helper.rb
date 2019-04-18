module PropertiesHelper
  def property_search_filters(filters)
    html = ""
    filters.each do |f|
      param = "filter_" + f.to_s
      html += '<label class="checkbox"><input'
      html += " checked" if params[param] == "on"
      html += ' type="checkbox" name="filter_' + f.to_s + '" onchange="this.form.submit()">'
      html += I18n.t("properties.filters." + f.to_s) + "</label>"
    end
    html
  end

  def classic_features(property)
    [].tap do |features|
      features << I18n.t("properties.features.bedrooms", bedrooms: property.number_of_bedrooms)
      features << I18n.t("properties.features.bathrooms", bathrooms: property.number_of_bathrooms)
      if property.for_rent?
        features << I18n.t("properties.features.sleeping_capacity", sleeping_capacity: property.sleeping_capacity)
        features << property.board_basis_description
        features << property.tv_description
        features << I18n.t("properties.features.wifi") if property.wifi?
        features << I18n.t("properties.features.long_term_lets_available") if property.long_term_lets_available?
        features << I18n.t("properties.features.short_stays") if property.short_stays?
        features << I18n.t("properties.features.smoking") if property.smoking?
        features << I18n.t("properties.features.disabled") if property.disabled?
        features << I18n.t("properties.features.pets") if property.pets?
        features << I18n.t("properties.features.children_welcome") if property.children_welcome?
      end
      features << I18n.t("properties.features.balcony") if property.balcony?
      features << I18n.t("properties.features.terrace") if property.terrace?
      features << I18n.t("properties.features.mountain_views") if property.mountain_views?
      features << I18n.t("properties.features.garden") if property.garden?
      features << property.parking_description
      features << I18n.t("properties.features.fully_equipped_kitchen") if property.fully_equipped_kitchen?
      features << I18n.t("properties.features.ski_in_ski_out") if property.ski_in_ski_out?
      features << I18n.t("properties.features.cave") if property.cave?
      features << I18n.t("properties.features.log_fire") if property.log_fire?
      features << I18n.t("properties.features.hot_tub") if property.hot_tub?
      features << I18n.t("properties.features.sauna") if property.sauna?
      features << I18n.t("properties.features.swimming_pool") if property.indoor_swimming_pool? || property.outdoor_swimming_pool?
    end
  end

  def new_classic_features(property)
    [].tap do |features|
      features << {title: I18n.t("property_type"), value: property_type(property), type: "text"}
      features << {title: I18n.t("plot_size") + " sqm", value: property.plot_size_metres_2, type: "text"}
      features << {title: I18n.t("bedrooms"), value: property.number_of_bedrooms, type: "text"}
      features << {title: I18n.t("bathrooms"), value: property.number_of_bathrooms, type: "text"}
      if property.for_rent?
        features << {title: I18n.t("properties.features.sleeping_capacity"), value: property.sleeping_capacity, type: "text"}
        features << {title: property.board_basis_description, type: "description"}
        features << {title: property.tv_description, type: "description"}
        features << {title: I18n.t("properties.features.wifi"), type: "bool"} if property.wifi?
        features << {title: I18n.t("properties.features.long_term_lets_available"), type: "bool"} if property.long_term_lets_available?
        features << {title: I18n.t("properties.features.short_stays"), type: "bool"} if property.short_stays?
        features << {title: I18n.t("properties.features.smoking"), type: "bool"} if property.smoking?
        features << {title: I18n.t("properties.features.disabled"), type: "bool"} if property.disabled?
        features << {title: I18n.t("properties.features.pets"), type: "bool"} if property.pets?
        features << {title: I18n.t("properties.features.children_welcome"), type: "bool"} if property.children_welcome?
      end
      features << {title: I18n.t("properties.features.balcony"), type: "bool"} if property.balcony?
      features << {title: I18n.t("properties.features.terrace"), type: "bool"} if property.terrace?
      features << {title: I18n.t("properties.features.mountain_views"), type: "bool"} if property.mountain_views?
      features << {title: I18n.t("properties.features.garden"), type: "bool"} if property.garden?
      features << {title: I18n.t("properties.features.fully_equipped_kitchen"), type: "bool"} if property.fully_equipped_kitchen?
      features << {title: I18n.t("properties.features.ski_in_ski_out"), type: "bool"} if property.ski_in_ski_out?
      features << {title: I18n.t("properties.features.cave"), type: "bool"} if property.cave?
      features << {title: I18n.t("properties.features.log_fire"), type: "bool"} if property.log_fire?
      features << {title: I18n.t("properties.features.hot_tub"), type: "bool"} if property.hot_tub?
      features << {title: I18n.t("properties.features.sauna"), type: "bool"} if property.sauna?
      features << {title: I18n.t("properties.features.swimming_pool"), type: "bool"} if property.indoor_swimming_pool? || property.outdoor_swimming_pool?
      features << {title: property.parking_description, type: "description"}
    end
  end

  def feature_tick(ticked, label)
    html = ""
    html += if ticked
      '<div class="ticked_feature"><span>Has</span>'
    else
      '<div class="unticked_feature"><span>Does not have</span>'
    end
    (html + " " + label + "</div>").html_safe
  end

  def featured_properties(properties)
    html = ""
    unless properties.nil?
      properties[0..2].each do |p|
        html += render partial: "properties/featured", locals: {p: p}
      end
    end
    raw html
  end

  def featured_property_price_message(p)
    if p.price_description.present?
      p.price_description
    else
      price = p.for_sale? ? format_currency(p.sale_price, p.currency) : format_currency(p.weekly_rent_price, p.currency)
      key = p.for_sale? ? "properties.featured.sale_price" : "properties.featured.weekly_price_from"
      t(key, price: price)
    end
  end

  def featured_property_alt_attribute(p)
    keys = {
      Property::LISTING_TYPE_FOR_RENT => ".alt_for_rent",
      Property::LISTING_TYPE_FOR_SALE => ".alt_for_sale",
    }
    t(keys[p.listing_type], resort: p.resort)
  end

  def listing_type_options
    [
      ["For rent", Property::LISTING_TYPE_FOR_RENT],
      ["For sale", Property::LISTING_TYPE_FOR_SALE],
    ]
  end

  def property_layout_options
    {"Default" => nil}.merge(Property::LAYOUTS.reject { |l| l.nil? }.map { |l| [l, l] }.to_h)
  end

  def distance_options
    [
      ["< 100m", 100],
      ["< 200m", 200],
      ["< 300m", 300],
      ["< 400m", 400],
      ["< 500m", 500],
      ["< 600m", 600],
      ["< 700m", 700],
      ["< 800m", 800],
      ["< 900m", 900],
      ["< 1,000m", 1000],
      ["1,000m+", 1001],
    ]
  end

  def booking_days(month, year)
    days = []
    (1..Time.days_in_month(month, year)).each do |day|
      days << ["#{Date.new(year, month, day).strftime("%a")[0..1]} #{day}", day]
    end
    days
  end

  def booking_months
    months = []
    first_month = Date.today.month
    last_month = first_month + 24
    (first_month..last_month).each do |month|
      year = Date.today.year + (month - 1) / 12
      month = (month - 1) % 12 + 1
      date = Date.new(year, month, 1)
      months << [date.strftime("%B %Y"), date.to_s[0..6]]
    end
    months
  end

  def booking_durations(nights = [])
    [
      ["1 night", 1],
      ["2 nights", 2],
      ["3 nights", 3],
      ["4 nights", 4],
      ["5 nights", 5],
      ["6 nights", 6],
      ["1 week", 7],
      ["8 nights", 8],
      ["9 nights", 9],
      ["10 nights", 10],
      ["11 nights", 11],
      ["12 nights", 12],
      ["13 nights", 13],
      ["2 weeks", 14],
      ["15 nights", 15],
      ["16 nights", 16],
      ["17 nights", 17],
      ["18 nights", 18],
      ["19 nights", 19],
      ["20 nights", 20],
      ["3 weeks", 21],
      ["22 nights", 22],
      ["23 nights", 23],
      ["24 nights", 24],
      ["25 nights", 25],
      ["26 nights", 26],
      ["27 nights", 27],
      ["4 weeks", 28],
    ].select { |option| nights.include?(option[1]) }
  end

  def additional_service_matched?(code, value)
    return false unless params[:additional_service]
    params[:additional_service][code] == value.to_s
  end

  def area_select(name, target)
    select_tag(
      name,
      '<option value="m">square metres</option><option value="f">square feet</option>'.html_safe,
      {data: {target: target}, class: "area-unit"}
    )
  end

  def sort_method
    params[:sort_method]
  end

  # Returns a string describing the property type.
  def property_type(property)
    if property.interhome_accommodation_id
      property_type_for_interhome(property.interhome_accommodation)
    else
      property_type_for_accommodation_type(property.accommodation_type)
    end
  end

  # Returns a string describing the property type based on Interhome
  # accommodation details.
  def property_type_for_interhome(interhome_accommodation)
    keys = {
      "A" => :apartment,
      "B" => :bungalow,
      "C" => :chalet,
      "H" => :holiday_resort,
      "V" => :villa,
    }
    type = keys[interhome_accommodation.details]

    # Most Interhome accommodation is classed as 'divers' (assuming: misc)
    # so let's dig into the description for clues.
    if type.nil?
      if interhome_accommodation.inside_description.downcase.index("villa")
        property_type_i18n(:villa)
      elsif interhome_accommodation.inside_description.downcase.index("chalet")
        property_type_i18n(:chalet)
      elsif interhome_accommodation.inside_description.downcase.index("apartment")
        property_type_i18n(:apartment)
      else
        property_type_i18n(:accommodation)
      end
    else
      property_type_i18n(type)
    end
  end

  # Returns a string describing the property type based on the property's
  # +accommodation_type+ attribute.
  def property_type_for_accommodation_type(accommodation_type)
    keys = {
      Property::ACCOMMODATION_TYPE_APARTMENT => :apartment,
      Property::ACCOMMODATION_TYPE_CHALET => :chalet,
      Property::ACCOMMODATION_TYPE_HOUSE => :house,
      Property::ACCOMMODATION_TYPE_VILLA => :villa,
    }
    keys.default = :accommodation
    property_type_i18n(keys[accommodation_type])
  end

  def property_type_i18n(key)
    I18n.t("helpers.properties.property_type.#{key}")
  end

  # Returns a property detail path based on the property type since different
  # routes are used for third-party content.
  def property_detail_path(property)
    if property.interhome_accommodation_id
      interhome_property_path(property.interhome_accommodation.permalink)
    else
      property_path(property)
    end
  end

  # Returns an appropriate booking URL for a property. If one has been provided
  # by the property owner then that is used, otherwise the contact property
  # path is returned.
  def booking_url(property)
    property.booking_url.present? ? property.booking_url : contact_property_path(property)
  end

  # Returns the <a> target attribute for a booking link.
  def booking_link_target(property)
    property.booking_url.present? ? "_blank" : "_self"
  end

  # Returns the i18n key to use for the link text of a link to a booking URL.
  # For properties for sale, this represents 'Enquire'. For rentals it
  # represents 'Make a booking'.
  def booking_link_text_key(property)
    property.for_sale? ? ".enquire" : ".make_a_booking"
  end

  # Returns true if the current page is the first page in a pagniated set.
  def first_page?
    params[:page].nil?
  end

  # Thumbnail image for property summary on property listing page.
  def property_summary_thumbnail(property)
    # We are purposely using the full image URL for the time being since our
    # thumbnails are often pretty large anyway.
    # This full image is usually around 800x600 and decently compressed; but
    # not guaranteed.
    property.image.url
  end

  # Returns <tt>:sales</tt>, <tt>:rentals</tt> or <tt>nil</tt> depending on the
  # type of search results page.
  def search_results_page_type
    action = controller.action_name
    if ["browse_for_sale", "new_developments"].include? action
      :sales
    elsif ["browse_for_rent", "quick_search"].include? action
      :rentals
    end
  end
end
