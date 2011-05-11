class CountriesController < ApplicationController
  before_filter :admin_required, :only => [:index]
  before_filter :find_country, :only => [:edit, :update, :show]

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

  protected

  def find_country
    @country = Country.find(params[:id])
  end
end
