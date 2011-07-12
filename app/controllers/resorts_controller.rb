class ResortsController < ApplicationController
  before_filter :admin_required, :except => [:show, :directory, :feature, :featured, :piste_map, :detail, :gallery]
  before_filter :find_resort, :only => [:edit, :update, :show, :destroy, :detail, :directory, :feature, :piste_map, :gallery]
  before_filter :no_browse_menu, :except => [:show, :feature, :directory]

  RESORTS_DIRECTORY = "#{Rails.root.to_s}/public/resorts/"

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
        set_image_mode
        format.html { redirect_to(new_image_path, :notice => t('notices.created')) }
        format.xml  { render :xml => @resort, :status => :created, :location => @resort }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resort.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    set_image_mode
  end

  def update
    respond_to do |format|
      if @resort.update_attributes(params[:resort])
        format.html { redirect_to(edit_resort_path(@resort), :notice => t('notices.saved')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resort.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    default_page_title "Summary and Snow/Weather Forecast for #{@resort} Ski Resort, #{@resort.country}"
    @stage_heading_a = I18n.t('stage_1_inactive')
    @stage_heading_b = I18n.t('stage_2')
    @heading_a = t('resorts_controller.resort_information_heading', :resort => @resort.name)
  end

  def destroy
    @resort.destroy

    respond_to do |format|
      format.html { redirect_to(resorts_url) }
      format.xml  { head :ok }
    end
  end

  def detail
    default_page_title "Detailed Information for #{@resort} Ski Resort, #{@resort.country}"
    @heading_a = render_to_string(:partial => 'detail_heading').html_safe
  end

  def directory
    @heading_a = "Directory for #{@resort.name}, #{@resort.country.name}"
    default_page_title @heading_a
    @categories = Category.order(:name).all
  end

  def featured
    @heading_a = I18n.t('featured_resorts')
  end

  def piste_map
    @heading_a = render_to_string(:partial => 'piste_map_heading').html_safe
    find_images 'piste-maps'
  end

  def gallery
    @heading_a = render_to_string(:partial => 'gallery_heading').html_safe
    find_images 'gallery'
  end

  def feature
  end

  protected

  def find_resort
    @resort = Resort.find_by_id(params[:id])
    redirect_to(resorts_path, :notice => t('resorts_controller.not_found')) unless @resort
  end

  def set_image_mode
    session[:image_mode] = 'resort'
    session[:resort_id] = @resort.id
  end

  def find_images sub_dir
    dir = "#{RESORTS_DIRECTORY}#{PermalinkFu.escape(@resort.name)}/#{sub_dir}"
    begin
      @images = Dir.entries(dir).select {|e| e[0..0] != "." && e.include?(".")}
    rescue
      @images = []
    end
  end
end
