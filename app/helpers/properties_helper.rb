module PropertiesHelper
  def property_search_filters filters
    html = ''
    filters.each do |f|
      param = 'filter_' + f.to_s
      html += '<label class="checkbox"><input'
      html += ' checked' if params[param]=='on'
      html += ' type="checkbox" name="filter_' + f.to_s + '" onchange="this.form.submit()">'
      html += I18n.t('properties.filters.' + f.to_s) + '</label>'
    end
    html
  end

  def feature_tick ticked, label
    html = ''
    if ticked
      html += '<div class="ticked_feature"><span>Has</span>'
    else
      html += '<div class="unticked_feature"><span>Does not have</span>'
    end
    (html + ' ' + label + '</div>').html_safe
  end

  def featured_properties(properties)
    html = ''
    unless properties.nil?
      properties[0..2].each do |p|
        html += render partial: 'properties/featured', locals: {p: p}
      end
    end
    raw html
  end

  def featured_property_price_message(p)
    price = p.for_sale? ? format_currency(p.sale_price, p.currency) : format_currency(p.weekly_rent_price, p.currency)
    key = p.for_sale? ? '.sale_price' : '.weekly_price_from'
    t(key, price: price)
  end

  def featured_property_alt_attribute(p)
    keys = {
      Property::LISTING_TYPE_FOR_RENT => '.alt_for_rent',
      Property::LISTING_TYPE_FOR_SALE => '.alt_for_sale',
      Property::LISTING_TYPE_HOTEL => '.alt_hotel'
    }
    t(keys[p.listing_type], resort: p.resort)
  end

  def listing_type_options
    [
      ["For rent", Property::LISTING_TYPE_FOR_RENT],
      ["For sale", Property::LISTING_TYPE_FOR_SALE],
      ["Hotel",    Property::LISTING_TYPE_HOTEL]
    ]
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
      ["1,000m+", 1001]
    ]
  end

  def booking_days(month, year)
    days = []
    (1..Time.days_in_month(month, year)).each do |day|
      days << ["#{Date.new(year, month, day).strftime('%a')[0..1]} #{day}", day]
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
      months << [date.strftime('%B %Y'), date.to_s[0..6]]
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
      ["4 weeks", 28]
    ].select { |option| nights.include?(option[1]) }
  end

  def additional_service_matched?(code, value)
    return false unless params[:additional_service]
    return params[:additional_service][code] == value.to_s
  end

  def area_select(name, target)
    select_tag(
      name,
      '<option value="m">square metres</option><option value="f">square feet</option>'.html_safe,
      { data: { target: target }, class: 'area-unit' }
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
      if property.listing_type == Property::LISTING_TYPE_HOTEL
        property_type_i18n(:hotel)
      else
        property_type_for_accommodation_type(property.accommodation_type)
      end
    end
  end

  # Returns a string describing the property type based on Interhome
  # accommodation details.
  def property_type_for_interhome(interhome_accommodation)
    keys = {
      'A' => :apartment,
      'B' => :bungalow,
      'C' => :chalet,
      'H' => :holiday_resort,
      'V' => :villa
    }
    type = property_type_i18n(keys[interhome_accommodation.details])

    # Most Interhome accommodation is classed as 'divers' (assuming: misc)
    # so let's dig into the description for clues.
    if type.nil?
      if interhome_accommodation.inside_description.downcase.index("villa")
        property_type_i18n(:villa)
      elsif interhome_accommodation.inside_description.downcase.index("chalet")
        property_type_i18n(:chalet)
      else
        property_type_i18n(:accommodation)
      end
    else
      type
    end
  end

  # Returns a string describing the property type based on the property's
  # +accommodation_type+ attribute.
  def property_type_for_accommodation_type(accommodation_type)
    keys = {
      Property::ACCOMMODATION_TYPE_APARTMENT => :apartment,
      Property::ACCOMMODATION_TYPE_CHALET    => :chalet
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
    elsif property.pv_accommodation_id
      pv_property_path(property.pv_accommodation.permalink)
    else
      property_path(property)
    end
  end

  # Returns an appropriate booking URL for a hotel.
  def hotel_booking_url(property)
    property.booking_url.present? ? property.booking_url : contact_property_path(property)
  end

  # Returns the <a> target attribute for a hotel booking link.
  def hotel_booking_link_target(property)
    property.booking_url.present? ? '_blank' : '_self'
  end
end
