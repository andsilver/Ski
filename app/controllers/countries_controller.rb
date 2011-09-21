class CountriesController < ApplicationController
  before_filter :admin_required, :except => [:show]
  before_filter :find_country, :only => [:edit, :update, :show, :destroy]
  before_filter :no_browse_menu, :except => [:show]

  def index
    @countries = Country.all(:order => 'name')
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(params[:country])

    if @country.save
      redirect_to(countries_path, :notice => t('notices.created'))
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @country.update_attributes(params[:country])
      redirect_to(countries_path, :notice => t('notices.saved'))
    else
      render "edit"
    end
  end

  def show
    @stage_heading_a = I18n.t('stage_1')
    @page_title = @heading_a = @country.name
  end

  def destroy
    @errors = []
    @errors << "This country has orders associated with it. " unless @country.orders.empty?
    @errors << "This country has order lines associated with it. " unless @country.order_lines.empty?
    @errors << "This country has resorts associated with it. " unless @country.resorts.empty?
    @errors << "This country has users associated with it. " unless @country.users.empty?
    if @errors.empty?
      #@country.destroy
      redirect_to countries_path, :notice => t('notices.deleted')
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
