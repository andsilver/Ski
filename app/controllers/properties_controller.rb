class PropertiesController < ApplicationController
  include SpamProtection

  CURRENTLY_ADVERTISED = ["id IN (SELECT adverts.property_id FROM adverts WHERE adverts.property_id=properties.id AND adverts.expires_at > NOW())"]

  before_filter :no_browse_menu, :except => [:browse_for_rent, :browse_for_sale]

  before_filter :user_required, :except => [:browse_for_rent, :browse_for_sale,
    :new_developments, :contact, :current_time, :show]
  before_filter :find_property_for_user, :only => [:edit, :update, :advertise_now]

  before_filter :resort_conditions, :only => [:browse_for_rent, :browse_for_sale]
  before_filter :find_resort, :only => [:browse_for_rent, :browse_for_sale]

  before_filter :find_property, :only => [:show, :contact, :email_a_friend]

  def browse_for_rent
    @heading_a = render_to_string(:partial => 'browse_property_heading').html_safe

    order = selected_order([ "normalised_weekly_rent_price ASC", "normalised_weekly_rent_price DESC",
      "metres_from_lift ASC", "sleeping_capacity ASC", "number_of_bedrooms ASC" ])
    @conditions[0] += " AND for_sale = 0"

    @search_filters = [:pets, :smoking, :tv, :satellite, :wifi, :disabled,
      :fully_equipped_kitchen]

    filter_conditions

    @properties = Property.paginate :page => params[:page], :order => order,
      :conditions => @conditions
    render "browse"
  end

  def browse_for_sale
    @for_sale = true
    @heading_a = render_to_string(:partial => 'browse_property_heading').html_safe

    order = selected_order([ 'normalised_sale_price ASC', 'normalised_sale_price DESC',
      'metres_from_lift ASC', 'number_of_bathrooms ASC',
      'number_of_bedrooms ASC' ])
    @conditions[0] += " AND for_sale = 1"

    @search_filters = [:garage, :parking, :private_garden]

    filter_conditions

    @properties = Property.paginate :page => params[:page], :order => order,
      :conditions => @conditions
    render "browse"
  end

  def new_developments
    @heading_a = I18n.t(:new_developments)
    @conditions = CURRENTLY_ADVERTISED.dup
    @conditions[0] += " AND new_development = 1"
    @properties = Property.paginate(:page => params[:page], :order => 'created_at DESC',
      :conditions => @conditions)
  end

  def new
    @property = Property.new
    @property.new_development = @current_user.role.new_development_by_default?
    if params[:for_sale]
      @property.for_sale = true
    end
  end

  def show
    @property.current_advert.record_view
    rent_or_sale = @property.for_sale? ? "Sale" : "Rent"
    @page_title = "#{@property.name} - Chalet / Apartment for #{rent_or_sale} in #{@property.resort}, #{@property.resort.country} - MySkiChalet"
  end

  def contact
    @enquiry = Enquiry.new
    @enquiry.property_id = @property.id
  end

  def email_a_friend
    @form = EmailAFriendForm.new
    @form.property_id = @property.id
  end

  def edit
    session[:property_id] = @property.id
  end

  def create
    @property = Property.new(params[:property])
    @property.user_id = @current_user.id

    if @property.save
      Advert.create_for(@property)
      session[:property_id] = @property.id
      redirect_to new_image_path, :notice => "Your property advert was successfully created. Now let's add some photos."
    else
      render :action => "new"
    end
  end

  def update
    if @property.update_attributes(params[:property])
      flash[:notice] = "Your property advert details have been saved."
      redirect_to my_adverts_path
    else
      render "edit"
    end
  end

  def advertise_now
    Advert.create_for(@property)
    redirect_to(basket_path, :notice => 'Your property advert has been added to your basket.')
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
    @resort = Resort.find(params[:id])
  end

  def selected_order(whitelist)
    whitelist.include?(params[:sort_method]) ? params[:sort_method] : whitelist.first
  end

  def resort_conditions
    @conditions = CURRENTLY_ADVERTISED.dup
    @conditions[0] += " AND resort_id = ?"
    @conditions << params[:id]
  end

  def filter_conditions
    @search_filters.each do |filter|
      @conditions[0] += " AND #{filter.to_s}=1" if params["filter_" + filter.to_s]
    end
  end
end
