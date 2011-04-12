class ResortsController < ApplicationController
  before_filter :admin_required, :except => [:show, :info]
  before_filter :find_resort, :only => [:edit, :update, :show, :info, :destroy]

  def index
    @countries = Country.with_resorts
  end

  def new
    @resort = Resort.new
    @resort.country_id = session[:last_country_id] unless session[:last_country_id].nil?
  end

  def create
    @resort = Resort.new(params[:resort])

    respond_to do |format|
      if @resort.save
        session[:last_country_id] = @resort.country_id
        format.html { redirect_to(resorts_path, :notice => 'Resort created.') }
        format.xml  { render :xml => @resort, :status => :created, :location => @resort }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resort.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @resort.update_attributes(params[:resort])
        format.html { redirect_to(resorts_path, :notice => 'Saved') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resort.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
    @resort.destroy

    respond_to do |format|
      format.html { redirect_to(resorts_url) }
      format.xml  { head :ok }
    end
  end

  protected

  def find_resort
    @resort = Resort.find_by_id(params[:id])
    redirect_to(resorts_path, :notice => 'That resort does not exist.') unless @resort
  end
end
