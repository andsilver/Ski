InterhomeBooking = Struct.new(:arrival_day, :arrival_month, :arrival_date, :duration, :adults, :children, :babies)

class PropertiesController < ApplicationController
  include SpamProtection

  before_filter :no_browse_menu, except: [:browse_for_rent, :browse_for_sale, :new_developments, :browse_hotels]

  before_filter :user_required, except: [
    :index, :browse_for_rent, :browse_for_sale,
    :new_developments, :browse_hotels, :contact,
    :email_a_friend, :current_time, :show,
    :show_interhome, :check_interhome_booking,
    :import_documentation]

  before_filter :find_property_for_user, only: [:edit, :update, :destroy, :advertise_now, :choose_window, :place_in_window, :remove_from_window]

  before_filter :resort_conditions, only: [:browse_for_rent, :browse_for_sale, :new_developments, :browse_hotels]
  before_filter :find_resort, only: [:browse_for_rent, :browse_for_sale, :new_developments, :browse_hotels]

  before_filter :find_property, only: [:show, :contact, :email_a_friend]

  before_filter :admin_required, only: [:index]

  def index
    @properties = Property.all
  end

  def browse_for_rent
    default_page_title t('properties.titles.browse_for_rent', resort: @resort)
    @heading_a = render_to_string(partial: 'browse_property_heading').html_safe

    order = selected_order([ "normalised_weekly_rent_price DESC", "normalised_weekly_rent_price ASC",
      "metres_from_lift ASC", "sleeping_capacity ASC", "number_of_bedrooms ASC" ])
    @conditions[0] += " AND listing_type = #{Property::LISTING_TYPE_FOR_RENT}"

    @search_filters = [:parking, :children_welcome, :pets, :smoking, :tv, :satellite, :wifi,
      :disabled, :long_term_lets_available, :short_stays, :ski_in_ski_out]

    filter_conditions

    unless params[:board_basis].nil? or params[:board_basis]=="-1"
      @conditions[0] += " AND board_basis = ?"
      @conditions << params[:board_basis]
    end

    @properties = Property.paginate(page: params[:page], order: order,
      conditions: @conditions)
    render 'browse'
  end

  def browse_for_sale
    @for_sale = true
    default_page_title t('properties.titles.browse_for_sale', resort: @resort)
    @heading_a = render_to_string(partial: 'browse_property_heading').html_safe

    order = for_sale_selected_order

    @conditions[0] += " AND listing_type = #{Property::LISTING_TYPE_FOR_SALE}"

    @search_filters = [:garage, :parking, :garden]

    filter_conditions

    @properties = Property.paginate(page: params[:page], order: order, conditions: @conditions)
    render "browse"
  end

  def new_developments
    @for_sale = true
    default_page_title t('properties.titles.new_developments', resort: @resort.name)
    @heading_a = t(:new_developments)
    @conditions[0] += " AND new_development = 1"

    order = for_sale_selected_order

    @search_filters = [:garage, :parking, :garden]

    filter_conditions

    @properties = Property.paginate(page: params[:page], order: order,
      conditions: @conditions)
    render "browse"
  end

  def browse_hotels
    @for_sale = false
    default_page_title t('properties.titles.hotels', resort: @resort)
    @heading_a = t('resort_options.hotels')

    order = selected_order([ "normalised_weekly_rent_price DESC", "normalised_weekly_rent_price ASC",
      "metres_from_lift ASC", "sleeping_capacity ASC", "star_rating DESC" ])

    @conditions[0] += " AND listing_type = #{Property::LISTING_TYPE_HOTEL}"

    @search_filters = []

    filter_conditions

    @properties = Property.paginate(page: params[:page], order: order, conditions: @conditions)
    render "browse"
  end

  def new
    default_page_title t('properties.titles.new')
    @heading_a = render_to_string(partial: 'new_property_heading').html_safe

    @property = Property.new
    @property.new_development = @current_user.role.new_development_by_default?
    if params[:listing_type]
      @property.listing_type = params[:listing_type]
    end
  end

  def show
    not_found and return unless @property.publicly_visible? or admin? or
      (@current_user && @current_user.id == @property.user_id)

    redirect_to "/accommodation/#{@property.interhome_accommodation.permalink}" and return if @property.interhome_accommodation

    @property.current_advert.record_view if @property.current_advert

    show_shared
    @advertiser_web_property_id = @property.user.google_web_property_id unless @property.user.google_web_property_id.blank?
  end

  def show_interhome
    @accommodation = InterhomeAccommodation.find_by_permalink(params[:permalink])
    not_found and return if @accommodation.nil?
    @property = @accommodation.property

    arrival = Date.today
    @interhome_booking = InterhomeBooking.new(arrival.to_s[8..9], arrival.to_s[0..6], arrival, 7, 2, 0, 0)

    show_shared
  end

  def check_interhome_booking
    @accommodation = InterhomeAccommodation.find_by_permalink(params[:permalink])
    check_in = params[:interhome_booking][:arrival_month] + '-' + '%02d' % params[:interhome_booking][:arrival_day]
    check_in_date = Date.new(check_in[0..3].to_i, check_in[5..6].to_i, check_in[8..9].to_i)
    check_out = (check_in_date + params[:interhome_booking][:duration].to_i.days).to_s
    details = {
      accommodation_code: @accommodation.code,
      adults: params[:interhome_booking][:adults],
      check_in: check_in,
      check_out: check_out,
      children: params[:interhome_booking][:children],
      babies: params[:interhome_booking][:babies]
    }
    @response = InterhomeWebServices.request('Availability', details)
    render layout: false
  end

  def contact
    default_page_title "Enquire About #{@property.name} in #{@property.resort}, #{@property.resort.country}"
    @heading_a = render_to_string(partial: 'contact_heading').html_safe

    @enquiry = Enquiry.new
    @enquiry.property_id = @property.id
  end

  def email_a_friend
    default_page_title t('properties.email_a_friend')
    @heading_a = render_to_string(partial: 'email_a_friend_heading').html_safe

    @form = EmailAFriendForm.new
    @form.property_id = @property.id
  end

  def edit
    set_image_mode
  end

  def create
    @property = Property.new(params[:property])
    @property.user_id = @current_user.id

    if @property.save
      set_image_mode
      if @current_user.role.advertises_through_windows?
        if Advert.assign_window_for(@property)
          notice = t('properties_controller.created_and_assigned_to_window')
        else
          notice = t('properties_controller.created_but_no_empty_windows_left')
        end
      else
        Advert.create_for(@property)
        notice = t('properties_controller.created')
      end
      redirect_to new_image_path, notice: notice
    else
      render action: 'new'
    end
  end

  def update
    if @property.update_attributes(params[:property])
      redirect_to my_adverts_path, notice: t('properties_controller.saved')
    else
      render "edit"
    end
  end

  def destroy
    @property.destroy
    redirect_to my_adverts_path(user_id: @property.user_id), notice: t('notices.deleted')
  end

  def advertise_now
    Advert.create_for(@property)
    redirect_to(basket_path, notice: t('properties_controller.added_to_basket'))
  end

  def choose_window
    @heading_a = render_to_string(partial: 'choose_window_heading').html_safe
  end

  def place_in_window
    advert = Advert.find_by_id_and_user_id(params[:advert_id], @current_user.id)
    if advert && advert.window?
      advert.property_id = @property.id
      advert.save
      redirect_to my_adverts_path, notice: t('properties_controller.placed_in_window')
    else
      redirect_to action: 'choose_window'
    end
  end

  def remove_from_window
    advert = @property.current_advert
    advert.property_id = nil
    advert.save!
    redirect_to my_adverts_path, notice: t('properties_controller.removed_from_window')
  end

  def new_import
  end

  def import
    cleanup_import 'No file uploaded' and return if params[:file].nil?

    @file = params[:file]
    @path = "#{Rails.root.to_s}/public/up/users/#{@current_user.id}/properties_upload"
    FileUtils.makedirs(@path)
    zip_filename = "#{@path}/properties.zip"
    File.open(zip_filename, "wb") { |file| file.write(@file.read) }
    zip_result = system("unzip -jo #{zip_filename} -d #{@path}")
    cleanup_import "Error extracting ZIP file" and return unless zip_result

    csv_filename = "#{@path}/properties.csv"
    cleanup_import "Could not find properties.csv in ZIP file" and return unless File.exists?(csv_filename)

    require 'csv'

    @total_read = @newly_imported = @updated = @failed = 0
    flash[:errors] = []

    csv = File.open(csv_filename, 'rb')
    @parsed_file = defined?(CSV::Reader) ? CSV::Reader.parse(csv) : CSV.parse(csv)

    @parsed_file.each do |row|
      begin
        process_row(row)
      rescue RuntimeError => e
        cleanup_import(e) and return
      end
    end

    cleanup_import "Total read: #{@total_read}, Newly imported: #{@newly_imported}, Updated: #{@updated}, Failed: #{@failed}"
  end

  def pericles_import
    default_resort = Resort.find_by_id(params[:resort_id])
    unless default_resort
      redirect_to new_pericles_import_properties_path, notice: 'Please select a default resort.'
      return
    end

    @path = "#{Rails.root.to_s}/public/up/users/#{@current_user.id}/properties_upload"
    xml_filename = "#{@path}/mbiarve.XML"

    require 'xmlsimple'

    @total_read = @newly_imported = @updated = @failed = 0
    flash[:errors] = []

    xml_file = File.open(xml_filename, 'rb')
    xml = XmlSimple.xml_in(xml_file)
    xml_file.close
    xml['BIEN'].each do |property_xml|
      @total_read += 1
      begin
        p_p = PericlesProperty.new(property_xml)
      rescue RuntimeError => e
        @failed += 1
        flash[:errors] << "Property with NO_ASP=#{property_xml['NO_ASP'][0]} failed: #{e}"
        next
      end
      puts p_p
      puts '-------'
      property = Property.find_by_user_id_and_pericles_id(@current_user.id, p_p.pericles_id)
      property ||= new_import_property

      new_record = property.new_record?
      p_p.prepare_property(property)
      property.tidy_name_and_strapline
      property.resort_id = default_resort.id

      p(property)
      puts '-------'

      if property.save
        GC.start if property.id % 50 == 0
        if new_record
          @newly_imported += 1
        else
          @updated += 1
        end
      else
        if @failed < 5
          error = "Problem with property in with NO_ASP=#{p_p.pericles_id}:"
          property.errors.full_messages.each do |msg|
            error += " [#{msg}]"
          end
          flash[:errors] << error
        else
          flash[:errors] << "Also NO_ASP=#{p_p.pericles_id}"
        end
        @failed += 1
      end

      process_imported_pericles_images(p_p, property) if new_record

    end

    redirect_to new_pericles_import_properties_path,
      notice: "Total read: #{@total_read}, Newly imported: #{@newly_imported}, Updated: #{@updated}, Failed: #{@failed}"
  end

  protected

  def show_shared
    rent_or_sale = @property.for_sale? ? t('for_sale') : t('for_rent')
    default_page_title t('properties.titles.show',
      property_name: @property.name, rent_or_sale: rent_or_sale,
      resort: @property.resort, country: @property.resort.country)
    @resort = @property.resort
    @heading_a = render_to_string(partial: 'show_property_heading').html_safe
    if @meta_description.blank?
      @meta_description = "#{@resort} Accommodation - #{@property.strapline[0..130]}"
    end
  end

  def process_row(row)
    if @mapping.nil?
      @mapping = csv_mapping_from_header(row)
      %w(resort_id name address description for_sale).each do |required|
        raise "CSV missing required field: #{required}" if @mapping[required].nil?
      end
      return
    end

    @total_read += 1

    property = Property.find_by_user_id_and_name(@current_user.id, row[@mapping['name']])
    property ||= new_import_property

    new_record = property.new_record?

    Property.importable_attributes.each do |attribute|
      unless @mapping[attribute].nil? || attribute == 'images'
        unless row[@mapping[attribute]].blank?
          property[attribute] = row[@mapping[attribute]]
          puts "#{attribute} = #{property[attribute]}"
        end
      end
    end

    property.tidy_name_and_strapline

    if property.save
      GC.start if property.id % 50 == 0
      if new_record
        @newly_imported += 1
      else
        @updated +=1
      end
    else
      if @failed < 5
        error = "Problem with property in row #{@total_read + 1}:"
        property.errors.full_messages.each do |msg|
          error += " [#{msg}]"
        end
        flash[:errors] << error
      else
        flash[:errors] << "Also row #{@total_read + 1}"
      end
      @failed += 1
    end

    if new_record and @mapping['images']
      process_imported_images(property, row[@mapping['images']])
    end
  end

  def new_import_property
    property = Property.new
    property.user_id = @current_user.id
    property.distance_from_town_centre_m = property.metres_from_lift = 0
    property
  end

  def process_imported_images(property, images)
    return if images.nil?

    image_filenames = images.split('|')
    first = true
    image_filenames.each do |filename|
      filename.strip!
      puts "processing image: #{filename}"

      image = nil
      if filename[0..3]=="http"
        image = Image.new(source_url: filename)
      else
        filename = File.basename(filename)
        path = "#{@path}/#{filename}"
        if File.exists? path
          file = File.open(path)
          image = Image.new
          image.image = file
          file.close
        end
      end

      unless image.nil?
        image.user_id = property.user_id
        image.property_id = property.id
        image.save
        if first
          property.image_id = image.id
          property.save
          first = false
        end
      end
    end
  end

  def process_imported_pericles_images(pericles_property, property)
    first = true
    ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o'].each do |letter|
      filename = "#{pericles_property.company_code}-#{pericles_property.site_code}-#{pericles_property.pericles_id}-#{letter}.jpg"
      puts "processing image: #{filename}"
      path = "#{@path}/#{filename}"
      if File.exists? path
        file = File.open(path)
        image = Image.new
        image.image = file
        image.user_id = property.user_id
        image.property_id = property.id
        image.save
        if first
          property.image_id = image.id
          property.save
          first = false
        end
        file.close
      end
    end
  end

  def cleanup_import notice
    FileUtils.rm_rf(@path) unless @path.nil?
    redirect_to new_import_properties_path, notice: notice
  end

  def csv_mapping_from_header(row)
    mapping = Hash.new
    row.each_with_index do |header, pos|
      puts "looking at: #{header}"
      mapping[header] = pos if Property.importable_attributes.include? header
    end
    puts mapping
    mapping
  end

  def find_property
    @property = Property.find_by_id(params[:id])
    not_found unless @property
  end

  def find_property_for_user
    if admin?
      @property = Property.find(params[:id])
    else
      @property = Property.find_by_id_and_user_id(params[:id], @current_user.id)
    end
    not_found unless @property
  end

  def find_resort
    @resort = Resort.find(params[:resort_id])
  end

  def selected_order(whitelist)
    whitelist.include?(params[:sort_method]) ? params[:sort_method] : whitelist.first
  end

  def for_sale_selected_order
    selected_order([ 'normalised_sale_price DESC', 'normalised_sale_price ASC',
      'metres_from_lift ASC', 'number_of_bathrooms ASC',
      'number_of_bedrooms ASC' ])
  end

  def resort_conditions
    @conditions = ["publicly_visible = 1 AND resort_id = ?"]
    @conditions << params[:resort_id]
  end

  def filter_conditions
    @search_filters.each do |filter|
      @conditions[0] += " AND #{filter_column(filter)}>=#{filter_threshold(filter)}" if params["filter_" + filter.to_s]
    end
  end

  def filter_column filter
    if filter == :satellite
      'tv'
    elsif filter == :garage
      'parking'
    else
      filter.to_s
    end
  end

  def filter_threshold filter
    if filter == :satellite
      Property::TV_SATELLITE
    elsif filter == :garage
      Property::PARKING_GARAGE
    else
      1
    end
  end

  def set_image_mode
    session[:image_mode] = 'property'
    session[:property_id] = @property.id
  end
end
