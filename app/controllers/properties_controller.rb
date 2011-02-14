class PropertiesController < ApplicationController
  def browse_for_rent
    @resort = Resort.find(params[:id])
    @properties = Property.paginate :page => params[:page], :order => 'title',
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
