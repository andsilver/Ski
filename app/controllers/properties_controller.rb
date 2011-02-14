class PropertiesController < ApplicationController
  before_filter :user_required, :except => [:browse_for_rent, :show]

  def browse_for_rent
    @resort = Resort.find(params[:id])
    whitelist = [ "weekly_rent_price DESC", "metres_from_lift ASC", "sleeping_capacity ASC",
      "number_of_bedrooms ASC" ]
    order = whitelist.include?(params[:sort_method]) ? params[:sort_method] : 'weekly_rent_price ASC'
    @properties = Property.paginate :page => params[:page], :order => order,
      :conditions => {:resort_id => params[:id]}
  end

  def my_for_rent
    @properties = @current_user.properties
  end

  def new
    @property = Property.new
  end

  def show
    @property = Property.find(params[:id])
  end

  def create
    @property = Property.new(params[:property])
    @property.user_id = @current_user.id

    respond_to do |format|
      if @property.save
        format.html { redirect_to(my_properties_for_rent_path, :notice => 'Your property advert was successfully created.') }
        format.xml  { render :xml => @property, :status => :created, :location => @property }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @property.errors, :status => :unprocessable_entity }
      end
    end
  end
end
