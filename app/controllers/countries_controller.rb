class CountriesController < ApplicationController
  before_filter :admin_required, :only => [:index]
  before_filter :find_country, :only => [:edit, :update, :show, :destroy]

  def index
    @countries = Country.all(:order => 'name')
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(params[:country])

    if @country.save
      redirect_to(countries_path, :notice => 'Country created.')
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @country.update_attributes(params[:country])
      redirect_to(countries_path, :notice => 'Saved')
    else
      render "edit"
    end
  end

  def show
    @heading_a = @country.name
  end

  def destroy
    @errors = []
    @errors << "This country has orders associated with it. " unless @country.orders.empty?
    @errors << "This country has resorts associated with it. " unless @country.resorts.empty?
    @errors << "This country has users associated with it. " unless @country.users.empty?
    if @errors.empty?
      #@country.destroy
      redirect_to countries_path, :notice => "Country deleted."
    else
      redirect_to countries_path, :notice => "This country could not be deleted because: " +
        @errors.join
    end
  end

  protected

  def find_country
    @country = Country.find(params[:id])
  end
end
