# frozen_string_literal: true

require_relative "../../lib/interhome.rb"

class PropertiesController < ApplicationController
  include SpamProtection

  before_action :user_required, except: %i[
    index quick_search
    browse_for_rent browse_for_sale
    new_developments contact
    current_time show
    show_interhome check_interhome_booking interhome_enquiry
    interhome_booking_form
    interhome_payment_success interhome_payment_failure
    update_booking_durations_select update_day_of_month_select
  ]

  before_action :no_header!, only: %i[contact show show_interhome show_pierret_et_vacances]

  before_action :find_property, only: %i[show contact]
  before_action :ensure_property_visibility, only: %i[show contact]

  before_action :find_property_for_user, only: %i[edit update destroy advertise_now choose_window place_in_window remove_from_window]

  SEARCH_PAGES = %i[
    browse_for_rent browse_for_sale new_developments quick_search
  ].freeze

  before_action :set_resort_and_region, only: SEARCH_PAGES
  before_action :set_country, only: [:quick_search]
  before_action :require_resort, only: SEARCH_PAGES - %i[quick_search browse_for_rent browse_for_sale]
  before_action :require_resort_or_region, only: %i[browse_for_rent browse_for_sale]
  before_action :protect_hidden_resort, only: SEARCH_PAGES
  before_action :location_conditions, only: SEARCH_PAGES
  before_action :holiday_type_conditions, only: SEARCH_PAGES

  before_action :admin_required, only: [:index]
  layout "admin", only: [:index]

  def index
    default_page_title "Properties"
    @properties = Property.order(:id).paginate(page: params[:page], per_page: 200)
  end

  def quick_search
    default_page_title t("properties.titles.browse_for_rent", place: place)
    browse_property_breadcrumbs
    @heading = t("properties_controller.quick_search.heading")

    order = selected_order(whitelist: order_whitelist, sort_method: params[:sort_method])
    @conditions[0] += " AND (listing_type = #{Property::LISTING_TYPE_FOR_RENT})"

    @search_filters = %i[parking children_welcome pets smoking tv wifi
                         disabled ski_in_ski_out]

    @search_filters <<= :long_term_lets_available if !@resort || Property.where(resort_id: @resort.id, long_term_lets_available: true).any?
    @search_filters <<= :short_stays if !@resort || Property.where(resort_id: @resort.id, short_stays: true).any?

    filter_duration
    filter_price_range
    filter_sleeps
    filter_availability

    filter_conditions

    unless params[:board_basis].nil? || (params[:board_basis] == "-1")
      @conditions[0] += " AND board_basis = ?"
      @conditions << params[:board_basis]
    end

    @properties = Property.where(@conditions).order(order).paginate(page: params[:page])
    render :browse, status: search_status
  end

  def browse_for_rent
    default_page_title t("properties.titles.browse_for_rent", place: place)
    browse_property_breadcrumbs

    @heading = I18n.t("properties_controller.browse_for_rent.heading." +
      browse_heading_key, place: place)

    order = selected_order(whitelist: order_whitelist, sort_method: params[:sort_method])
    @conditions[0] += " AND listing_type = #{Property::LISTING_TYPE_FOR_RENT}"

    @search_filters = %i[parking children_welcome pets smoking tv wifi
                         disabled long_term_lets_available short_stays ski_in_ski_out]

    filter_availability
    filter_sleeps
    filter_bedrooms
    filter_conditions

    unless params[:board_basis].nil? || (params[:board_basis] == "-1")
      @conditions[0] += " AND board_basis = ?"
      @conditions << params[:board_basis]
    end

    find_properties(order)

    render :browse, status: search_status
  end

  def browse_for_sale
    default_page_title t("properties.titles.browse_for_sale", place: place)
    browse_property_breadcrumbs

    @heading = I18n.t("properties_controller.browse_for_sale.heading." +
      browse_heading_key, place: place)

    order = selected_order(whitelist: for_sale_order_whitelist, sort_method: params[:sort_method])

    @conditions[0] += " AND listing_type = #{Property::LISTING_TYPE_FOR_SALE}"

    @search_filters = %i[garage parking garden]

    filter_conditions
    find_properties(order)

    render :browse, status: search_status
  end

  def new_developments
    default_page_title t("properties.titles.new_developments", resort: @resort.name)
    @breadcrumbs = {@resort.name => @resort}
    @heading = t(:new_developments)
    @conditions[0] += " AND new_development = 1"

    order = selected_order(whitelist: for_sale_order_whitelist, sort_method: params[:sort_method])

    @search_filters = %i[garage parking garden]

    filter_conditions
    find_properties(order)

    render :browse, status: search_status
  end

  def new
    @property = Property.new
    @property.new_development = current_user.role.new_development_by_default?
    @property.listing_type = params[:listing_type] if params[:listing_type]
  end

  def show
    if @property.interhome_accommodation
      flash.keep
      redirect_to "/accommodation/#{@property.interhome_accommodation.permalink}"
      return
    end

    @property.current_advert&.record_view

    show_shared
    @advertiser_web_property_id = @property.user.google_web_property_id unless @property.user.google_web_property_id.blank?

    render @property.template
    # render 'show_property_for_sale'
  end

  def show_interhome
    @accommodation = InterhomeAccommodation.find_by(permalink: params[:permalink])
    not_found && return if @accommodation.nil?
    @property = @accommodation.property

    if @property.nil?
      @accommodation.destroy
      not_found
      return
    end

    show_shared
  end

  # Responds to an XHR with a booking form for the given Interhome
  # accommodation. XHR is used since rendering the booking form can take a
  # while. This allows the containing page to be rendered independently and
  # faster.
  #
  # Most Interhome accommodations will have vacancy information but it is not
  # guaranteed since it is contained in a separate feed. In the case of missing
  # vacancy information, the <tt>interhome_no_vacancy_info</tt> template is
  # rendered.
  def interhome_booking_form
    @accommodation = InterhomeAccommodation.find(params[:id])
    @property = @accommodation.property

    arrival = Date.today
    @interhome_booking = Interhome::Booking.new(arrival.to_s[8..9], arrival.to_s[0..6], arrival, 7, 2, 0, 0)

    if @accommodation.interhome_vacancy
      render layout: false
    else
      render template: "properties/interhome_no_vacancy_info", layout: false
    end
  end

  def interhome_enquiry
    InterhomeNotifier.request_enquiry(params).deliver_now
  end

  def check_interhome_booking
    @accommodation = InterhomeAccommodation.find_by(permalink: params[:permalink])
    @property = @accommodation.property
    check_in = params[:interhome_booking][:arrival_month] + "-" + format("%02d", params[:interhome_booking][:arrival_day])
    begin
      check_in_date = Date.new(check_in[0..3].to_i, check_in[5..6].to_i, check_in[8..9].to_i)
    rescue
      @message = "Please choose a valid check in date."
      render("interhome_error", layout: false) && return
    end
    check_out = (check_in_date + params[:interhome_booking][:duration].to_i.days).to_s
    details = {
      accommodation_code: @accommodation.code,
      adults: params[:interhome_booking][:adults].to_i.to_s,
      check_in: check_in,
      check_out: check_out,
      children: params[:interhome_booking][:children].to_i.to_s,
      babies: params[:interhome_booking][:babies].to_i.to_s,
    }
    @adults = details[:adults].to_i
    @babies = details[:babies].to_i
    @children = details[:children].to_i
    pax = @children + @adults
    if pax > @accommodation.pax
      @message = "The number of people (adults + children) exceeds the capacity for this property."
      render("interhome_error", layout: false) && return
    elsif @adults < 1
      @message = "At least 1 adult must be included."
      render("interhome_error", layout: false) && return
    end

    if params[:additional_service]
      # convert ticked check boxes to '1'
      params[:additional_service].each do |key, val|
        params[:additional_service][key] = "1" if val == "on"
      end
      details[:additional_services] = params[:additional_service]
    end

    if params[:submit] == "Book"
      return if make_interhome_booking(details)
    end

    @availability = Interhome::WebServices.request("Availability", details)
    if @availability.available?
      @price_detail = Interhome::WebServices.request("PriceDetail", details)
      @additional_services = Interhome::WebServices.request("AdditionalServices", details)
    else
      InterhomeNotifier.unavailability_report(@accommodation, details).deliver
    end
    render layout: false
  end

  def update_booking_durations_select
    @nights = params[:nights].split(",").map(&:to_i)
    render layout: false
  end

  def update_day_of_month_select
    if params[:year_month]
      @year = params[:year_month][0..3].to_i
      @month = params[:year_month][5..6].to_i
    else
      @year = Time.now.year
      @month = Time.now.month
    end
    render layout: false
  end

  def make_interhome_booking(details)
    @conditions = Interhome::WebServices.request("CancellationConditions", details).conditions
    @price_detail = Interhome::WebServices.request("PriceDetail", details)
    @deposit = @price_detail.prepayment != "0"
    @amount = @deposit ? @price_detail.prepayment : @price_detail.total
    @amount_in_cents = (@amount.to_f * 100).to_i
    details[:payment_type] = "SecuredCreditCard"
    details[:credit_card_type] = "NotSet"
    details[:customer_salutation_type] = params[:customer_salutation_type]
    details[:customer_first_name] = params[:customer_first_name]
    details[:customer_name] = params[:customer_name]
    details[:customer_email] = params[:customer_email]
    details[:customer_address_street] = params[:customer_address_street]
    details[:customer_address_additional_street] = params[:customer_address_additional_street]
    details[:customer_address_place] = params[:customer_address_place]
    details[:customer_address_zip] = params[:customer_address_zip]
    details[:customer_address_country_code] = params[:customer_address_country_code]

    @client_booking = Interhome::WebServices.request("ClientBooking", details)

    details[:booking_id] = @client_booking.booking_id
    details[:property] = InterhomeAccommodation.find_by(permalink: params[:permalink]).property
    details[:permalink] = params[:permalink]
    details[:total] = @price_detail.total
    InterhomeNotifier.booking_confirmation(details).deliver
    render("interhome_payment", layout: false)
  end

  def contact
    @enquiry = Enquiry.new(property: @property)
  end

  def edit
    default_page_title t("properties.titles.edit")
    set_image_mode
  end

  def create
    @property = Property.new(property_params)
    @property.user_id = current_user.id

    if @property.save
      set_image_mode
      if current_user.advertises_through_windows?
        notice = if Advert.assign_window_for(@property)
          t("properties_controller.created_and_assigned_to_window")
        else
          t("properties_controller.created_but_no_empty_windows_left")
        end
      else
        Advert.create_for(@property)
        notice = t("properties_controller.created")
      end
      redirect_to new_image_path, notice: notice
    else
      render action: "new"
    end
  end

  def update
    if params[:property][:image_id].present?
      image = Image.find(params[:property][:image_id])
      @property.image = image if image.user == @property.user
    end

    if @property.update_attributes(property_params)
      redirect_to my_adverts_path, notice: t("properties_controller.saved")
    else
      render :edit
    end
  end

  def destroy
    @property.destroy
    redirect_to my_adverts_path(user_id: @property.user_id), notice: t("notices.deleted")
  end

  def advertise_now
    Advert.create_for(@property)
    redirect_to(basket_path, notice: t("properties_controller.added_to_basket"))
  end

  def choose_window
    @heading_a = render_to_string(partial: "choose_window_heading").html_safe
  end

  def place_in_window
    advert = Advert.find_by(id: params[:advert_id], user_id: current_user.id)
    if advert&.window?
      if advert.expired?
        redirect_to({action: "choose_window"}, notice: "That window has expired.")
      else
        advert.property_id = @property.id
        advert.save
        redirect_to my_adverts_path, notice: t("properties_controller.placed_in_window")
      end
    else
      redirect_to action: "choose_window"
    end
  end

  def remove_from_window
    advert = @property.current_advert
    advert.property_id = nil
    advert.save!
    redirect_to my_adverts_path, notice: t("properties_controller.removed_from_window")
  end

  protected

  include PropertyOrdering

  def find_properties(order)
    @properties = Property.where(@conditions).order(order).paginate(page: params[:page], per_page: Property.per_page)
  end

  def show_shared
    rent_or_sale = @property.for_sale? ? t("for_sale") : t("for_rent")
    default_page_title t("properties.titles.show",
      property_name: @property.name, rent_or_sale: rent_or_sale,
      resort: @property.resort, country: @property.resort.country)
    @resort = @property.resort
    default_meta_description(resort: @resort, strapline: @property.strapline[0..130])

    @heading = @property.name
    @property = @property.decorate
  end

  def find_property
    @property = Property.find_by(id: params[:id])
    if @property
      @resort = @property.resort
    else
      not_found
    end
  end

  def ensure_property_visibility
    not_found unless @property.publicly_visible? || admin? ||
      (current_user && current_user.id == @property.user_id)
  end

  def find_property_for_user
    @property = if admin?
      Property.find(params[:id])
    else
      Property.find_by(id: params[:id], user_id: current_user.id)
    end
    not_found unless @property
  end

  def set_resort_and_region
    @region = @resort = nil

    if params[:resort_slug]
      @resort = Resort.find_by(slug: params[:resort_slug])
      # A slug in params[:resort_slug] may refer to a region since a single
      # +select+ field is used in the UI.
      @region = Region.find_by(slug: params[:resort_slug])
    elsif params[:region_slug]
      @region = Region.find_by(slug: params[:region_slug])
    end
  end

  def set_country
    @country = (Country.find_by(id: params[:country_id]) if params[:country_id])
  end

  def require_resort
    not_found unless @resort
  end

  def require_resort_or_region
    not_found unless @resort || @region
  end

  def protect_hidden_resort
    not_found if @resort && !@resort.visible? && !admin?
  end

  def location_conditions
    if @resort
      @conditions = ["publicly_visible = 1 AND resort_id = ?"]
      @conditions << @resort.id
    elsif @region
      @conditions = ["publicly_visible = 1 AND region_id = ?"]
      @conditions << @region.id
    elsif @country
      @conditions = ["publicly_visible = 1 AND country_id = ?"]
      @conditions << @country.id
    else
      @conditions = ["publicly_visible = 1"]
    end
  end

  def holiday_type_conditions
    if params[:holiday_type_id]
      if @resort || @region
        @conditions[0] += if @resort
          " AND resort_id IN(SELECT brochurable_id FROM holiday_type_brochures WHERE brochurable_type = 'Resort' AND holiday_type_id = ?)"
        else
          " AND region_id IN(SELECT brochurable_id FROM holiday_type_brochures WHERE brochurable_type = 'Region' AND holiday_type_id = ?)"
        end
        @conditions << params[:holiday_type_id]
      end
    end
  end

  def filter_conditions
    @search_filters.each do |filter|
      @conditions[0] += " AND #{filter_column(filter)}>=#{filter_threshold(filter)}" unless params["filter_" + filter.to_s].blank?
    end
  end

  def filter_column(filter)
    if filter == :satellite
      "tv"
    elsif filter == :garage
      "parking"
    else
      filter.to_s
    end
  end

  def filter_threshold(filter)
    if filter == :satellite
      Property::TV_SATELLITE
    elsif filter == :garage
      Property::PARKING_GARAGE
    else
      1
    end
  end

  def filter_price_range
    return if params[:price_range].blank? || !%w[1 2 3 4 5 6 7 8].include?(params[:price_range])

    ranges = [
      [0, 300],
      [300, 450],
      [450, 600],
      [600, 800],
      [800, 1000],
      [1000, 1250],
      [1250, 1500],
      [1500, 10_000],
    ]
    min = ranges[params[:price_range].to_i - 1][0]
    max = ranges[params[:price_range].to_i - 1][1]
    @conditions[0] += " AND normalised_weekly_rent_price >= ? AND normalised_weekly_rent_price <= ?"
    @conditions << min
    @conditions << max
  end

  def filter_sleeps
    return if params[:sleeps].blank?

    sleeps = params[:sleeps].to_i
    @conditions[0] += " AND sleeping_capacity >= ? AND sleeping_capacity <= ?"
    @conditions << sleeps
    @conditions << sleeps * 2
  end

  def filter_bedrooms
    return if params[:bedrooms].blank?

    bedrooms = params[:bedrooms].to_i
    @conditions[0] += " AND number_of_bedrooms >= ? AND number_of_bedrooms <= ?"
    @conditions << bedrooms
    @conditions << bedrooms + 2
  end

  def filter_duration
    if params[:duration] == "long"
      @conditions[0] += " AND long_term_lets_available = 1"
    elsif params[:duration] == "short"
      @conditions[0] += " AND short_stays = 1"
    end
  end

  def filter_availability
    if params[:start_date].present?
      begin
        from = Date.parse(params[:start_date])
      rescue
        return
      end

      if params[:end_date].present?
        begin
          to = Date.parse(params[:end_date])
        rescue
          to = from + 1.day
        end
        return if to == from

        to, from = from, to if from > to
      else
        to = from + 1.day
      end

      day_after_check_in = from + 1.day
      day_before_check_out = to - 1.day

      @conditions[0] += " AND id IN (SELECT property_id FROM availabilities WHERE start_date = ? AND check_in = 1 AND availability = #{Availability::AVAILABLE})"
      @conditions << from

      internal_dates = *(day_after_check_in..day_before_check_out)
      if internal_dates.any?
        @conditions[0] += " AND (SELECT COUNT(property_id) FROM availabilities WHERE start_date IN (?) AND availability = #{Availability::AVAILABLE} AND availabilities.property_id = properties.id) = ?"
        @conditions << internal_dates
        @conditions << internal_dates.count
      end

      @conditions[0] += " AND id IN (SELECT property_id FROM availabilities WHERE start_date = ? AND check_out = 1)"
      @conditions << to
    end
  end

  def set_image_mode
    session[:image_mode] = "property"
    session[:property_id] = @property.id
  end

  def property_params
    convert_square_feet_to_square_metres
    params.require(:property).permit(:accommodation_type, :address, :balcony,
                                     :board_basis, :booking_url, :cave,
                                     :children_welcome, :currency_id, :description, :disabled,
                                     :distance_from_town_centre_m, :floor_area_metres_2,
                                     :fully_equipped_kitchen, :garden, :hot_tub, :indoor_swimming_pool,
                                     :latitude, :layout, :listing_type, :log_fire,
                                     :long_term_lets_available, :longitude,
                                     :mountain_views, :name, :new_development, :number_of_bathrooms,
                                     :number_of_bedrooms, :outdoor_swimming_pool, :parking, :pets,
                                     :plot_size_metres_2, :postcode,
                                     :price_description,
                                     :resort_id, :sale_price,
                                     :sauna, :short_stays, :ski_in_ski_out, :sleeping_capacity, :smoking,
                                     :strapline, :terrace, :tv, :weekly_rent_price, :wifi, :min_stay, :price_per_night,
                                     :video, :energy_performance, :floorplan)
  end

  def convert_square_feet_to_square_metres
    if params[:floor_area_unit] == "f"
      params[:property][:floor_area_metres_2] = to_square_metres(params[:property][:floor_area_metres_2])
    end
    if params[:plot_area_unit] == "f"
      params[:property][:plot_size_metres_2] = to_square_metres(params[:property][:plot_size_metres_2])
    end
  end

  def to_square_metres(square_feet)
    (square_feet.to_f * 0.09290304).round.to_s
  end

  def browse_property_breadcrumbs
    @breadcrumbs = {}
    @breadcrumbs[@resort.name] = @resort if @resort
  end

  def browse_heading_key
    if @resort.try(:ski?)
      "ski"
    elsif @resort.try(:summer?)
      "summer"
    else
      "other"
    end
  end

  def search_status
    @properties.any? ? 200 : 404
  end

  def place
    @resort || @region
  end
end
