class PropertiesController < ApplicationController
  include SpamProtection

  CURRENTLY_ADVERTISED = ["id IN (SELECT adverts.property_id FROM adverts WHERE adverts.property_id=properties.id AND adverts.expires_at > NOW())"]

  before_filter :no_browse_menu, :except => [:browse_for_rent, :browse_for_sale, :new_developments]

  before_filter :user_required, :except => [:browse_for_rent, :browse_for_sale,
    :new_developments, :contact, :email_a_friend, :current_time, :show]
  before_filter :find_property_for_user, :only => [:edit, :update, :advertise_now]

  before_filter :resort_conditions, :only => [:browse_for_rent, :browse_for_sale, :new_developments]
  before_filter :find_resort, :only => [:browse_for_rent, :browse_for_sale, :new_developments]

  before_filter :find_property, :only => [:show, :contact, :email_a_friend]

  def browse_for_rent
    default_page_title t('properties.titles.browse_for_rent', :resort => @resort.name)
    @heading_a = render_to_string(:partial => 'browse_property_heading').html_safe

    order = selected_order([ "normalised_weekly_rent_price ASC", "normalised_weekly_rent_price DESC",
      "metres_from_lift ASC", "sleeping_capacity ASC", "number_of_bedrooms ASC" ])
    @conditions[0] += " AND for_sale = 0"

    @search_filters = [:parking, :children_welcome, :pets, :smoking, :tv, :satellite, :wifi,
      :disabled, :long_term_lets_available, :short_stays, :ski_in_ski_out]

    filter_conditions

    @properties = Property.paginate :page => params[:page], :order => order,
      :conditions => @conditions
    render "browse"
  end

  def browse_for_sale
    @for_sale = true
    default_page_title t('properties.titles.browse_for_sale', :resort => @resort.name)
    @heading_a = render_to_string(:partial => 'browse_property_heading').html_safe

    order = for_sale_selected_order

    @conditions[0] += " AND for_sale = 1"

    @search_filters = [:garage, :parking, :garden]

    filter_conditions

    @properties = Property.paginate :page => params[:page], :order => order,
      :conditions => @conditions
    render "browse"
  end

  def new_developments
    default_page_title t('properties.titles.new_developments', :resort => @resort.name)
    @heading_a = I18n.t(:new_developments)
    @conditions[0] += " AND new_development = 1"

    order = for_sale_selected_order

    @search_filters = [:garage, :parking, :garden]

    filter_conditions

    @properties = Property.paginate(:page => params[:page], :order => order,
      :conditions => @conditions)
    render "browse"
  end

  def new
    default_page_title t('properties.titles.new')
    @heading_a = render_to_string(:partial => 'new_property_heading').html_safe

    @property = Property.new
    @property.new_development = @current_user.role.new_development_by_default?
    if params[:for_sale]
      @property.for_sale = true
    end
  end

  def show
    @property.current_advert.record_view if @property.current_advert
    rent_or_sale = @property.for_sale? ? t('for_sale') : t('for_rent')
    default_page_title t('properties.titles.show',
      :property_name => @property.name, :rent_or_sale => rent_or_sale,
      :resort => @property.resort, :country => @property.resort.country)
    @heading_a = render_to_string(:partial => 'show_property_heading').html_safe
  end

  def contact
    default_page_title "Enquire About #{@property.name} in #{@property.resort}, #{@property.resort.country}"
    @heading_a = render_to_string(:partial => 'contact_heading').html_safe

    @enquiry = Enquiry.new
    @enquiry.property_id = @property.id
  end

  def email_a_friend
    default_page_title t('properties.email_a_friend')
    @heading_a = render_to_string(:partial => 'email_a_friend_heading').html_safe

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
      Advert.create_for(@property)
      set_image_mode
      redirect_to new_image_path, :notice => t('properties_controller.created')
    else
      render :action => "new"
    end
  end

  def update
    if @property.update_attributes(params[:property])
      redirect_to my_adverts_path, :notice => t('properties_controller.saved')
    else
      render "edit"
    end
  end

  def advertise_now
    Advert.create_for(@property)
    redirect_to(basket_path, :notice => t('properties_controller.added_to_basket'))
  end

  protected

  def find_property
    @property = Property.find_by_id(params[:id])
    not_found unless @property
  end

  def find_property_for_user
    @property = Property.find_by_id_and_user_id(params[:id], @current_user.id)
    not_found unless @property
  end

  def find_resort
    @resort = Resort.find(params[:resort_id])
  end

  def selected_order(whitelist)
    whitelist.include?(params[:sort_method]) ? params[:sort_method] : whitelist.first
  end

  def for_sale_selected_order
    selected_order([ 'normalised_sale_price ASC', 'normalised_sale_price DESC',
      'metres_from_lift ASC', 'number_of_bathrooms ASC',
      'number_of_bedrooms ASC' ])
  end

  def resort_conditions
    @conditions = CURRENTLY_ADVERTISED.dup
    @conditions[0] += " AND resort_id = ?"
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
    else
      filter.to_s
    end
  end

  def filter_threshold filter
    if filter == :satellite
      Property::TV_SATELLITE
    else
      1
    end
  end

  def set_image_mode
    session[:image_mode] = 'property'
    session[:property_id] = @property.id
  end
end
