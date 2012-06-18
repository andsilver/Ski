class ResortsController < ApplicationController
  before_filter :admin_required, :except => [:show, :directory, :feature, :featured, :piste_map, :piste_map_full_size, :resort_guide, :gallery, :summer_holidays]
  before_filter :find_resort, :only => [:edit, :update, :show, :destroy, :resort_guide, :directory, :feature, :piste_map, :piste_map_full_size, :gallery, :summer_holidays]
  before_filter :no_browse_menu, :except => [:show, :feature, :directory, :resort_guide, :summer_holidays]

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

    @interhome_place_resort = InterhomePlaceResort.new(:resort_id => @resort.id)
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
    default_page_title "#{@resort} | Ski Holiday Accommodation | Chalets & Apartments for Rent & Sale"
    @heading_a = t('resorts_controller.resort_information_heading', :resort => @resort.name)
    @featured_properties = Property.order('RAND()').limit(12).where(publicly_visible: true, resort_id: @resort.id)
  end

  def destroy
    @resort.destroy

    respond_to do |format|
      format.html { redirect_to(resorts_url) }
      format.xml  { head :ok }
    end
  end

  def resort_guide
    default_page_title "Detailed Information for #{@resort} Ski Resort, #{@resort.country}"
    @heading_a = render_to_string(partial: 'detail_heading').html_safe
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
  end

  def piste_map_full_size
    @heading_a = render_to_string(:partial => 'piste_map_heading').html_safe
    @map = params[:map]
    render :layout => nil
  end

  def gallery
    @heading_a = render_to_string(:partial => 'gallery_heading').html_safe
  end

  def feature
  end

  def summer_holidays
    @heading_a = t('resorts_controller.detail.summer_holidays_in', resort: @resort)
    default_page_title @heading_a
  end

  protected

  def find_resort
    @resort = Resort.find_by_id(params[:id])
    if admin?
      redirect_to(resorts_path, :notice => t('resorts_controller.not_found')) unless @resort
    else
      not_found if !@resort || !@resort.visible?
    end
  end

  def set_image_mode
    session[:image_mode] = 'resort'
    session[:resort_id] = @resort.id
  end
end
