class PropertiesController < ApplicationController
  include SpamProtection

  before_filter :user_required, :except => [:browse_for_rent,
    :new_developments, :contact, :current_time, :show]
  before_filter :find_property_for_user, :only => [:edit, :update]

  def browse_for_rent
    @resort = Resort.find(params[:id])
    whitelist = [ "weekly_rent_price DESC", "metres_from_lift ASC", "sleeping_capacity ASC",
      "number_of_bedrooms ASC" ]
    order = whitelist.include?(params[:sort_method]) ? params[:sort_method] : 'weekly_rent_price ASC'
    @properties = Property.paginate :page => params[:page], :order => order,
      :conditions => {:resort_id => params[:id], :for_sale => false}
  end

  def my_for_rent
    @properties = @current_user.properties_for_rent
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
      advert = Advert.new_for(@property)
      advert.months = 3
      advert.save!
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

  protected

  def find_property_for_user
    @property = Property.find_by_id_and_user_id(params[:id], @current_user.id)
    not_found unless @property
  end
end
