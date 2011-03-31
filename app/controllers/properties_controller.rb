class PropertiesController < ApplicationController
  include SpamProtection

  before_filter :user_required, :except => [:browse_for_rent,
    :new_developments, :contact, :current_time, :show]
  before_filter :find_property_for_user, :only => [:edit, :update, :advertise_now]

  before_filter :find_resort, :only => [:browse_for_rent, :browse_for_sale]

  def browse_for_rent
    order = selected_order([ "weekly_rent_price ASC", "weekly_rent_price DESC",
      "metres_from_lift ASC", "sleeping_capacity ASC", "number_of_bedrooms ASC" ])
    @conditions = {:resort_id => params[:id], :for_sale => false}

    @search_filters = [:pets, :smoking, :tv, :satellite, :wifi, :disabled,
      :fully_equipped_kitchen, :parking]

    filter_conditions

    @properties = Property.paginate :page => params[:page], :order => order,
      :conditions => @conditions
    render "browse"
  end

  def browse_for_sale
    order = selected_order([ 'sale_price ASC', 'sale_price DESC',
      'metres_from_lift ASC', 'number_of_bathrooms ASC',
      'number_of_bedrooms ASC' ])
    @conditions = {:resort_id => params[:id], :for_sale => true}

    @search_filters = [:private_garden]

    @properties = Property.paginate :page => params[:page], :order => order,
      :conditions => @conditions
    @for_sale = true
    render "browse"
  end

  def my_for_rent
    @properties = @current_user.properties_for_rent
  end

  def my_for_sale
    @properties = @current_user.properties_for_sale
  end

  def new_developments
    @properties = Property.paginate(:page => params[:page], :order => 'created_at DESC',
      :conditions => {:new_development => true})
  end

  def new
    @property = Property.new
    if params[:for_sale]
      @property.for_sale = true
    end
  end

  def show
    @property = Property.find_by_id(params[:id])
    if @property
      @enquiry = Enquiry.new
      @enquiry.property_id = @property.id
    else
      not_found
    end
  end

  def edit
  end

  def create
    @property = Property.new(params[:property])
    @property.user_id = @current_user.id

    if @property.save
      create_advert
      redirect_to(basket_path, :notice => 'Your property advert was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    if @property.update_attributes(params[:property])
      redirect_to my_properties_for_rent_path, :notice => "Your property advert details have been saved."
    else
      render "edit"
    end
  end

  def advertise_now
    create_advert
    redirect_to(basket_path, :notice => 'Your property advert has been added to your basket.')
  end

  protected

  def find_property_for_user
    @property = Property.find_by_id_and_user_id(params[:id], @current_user.id)
    not_found unless @property
  end

  def create_advert
    advert = Advert.new_for(@property)
    advert.months = 3
    advert.save!
  end

  def find_resort
    @resort = Resort.find(params[:id])
  end

  def selected_order(whitelist)
    whitelist.include?(params[:sort_method]) ? params[:sort_method] : whitelist.first
  end

  def filter_conditions
    @search_filters.each do |filter|
      @conditions[filter] = true if params["filter_" + filter.to_s]
    end
  end
end
