class Admin::ResortsController < ApplicationController
  before_action :admin_required
  before_action :set_resort, only: [:edit, :update, :destroy, :edit_page]
  layout 'admin'

  def index
    @countries = Country.with_resorts
  end

  def new
    @resort = Resort.new
    @resort.country_id = session[:last_country_id] unless session[:last_country_id].nil?
  end

  def create
    @resort = Resort.new(resort_params)

    if @resort.save
      session[:last_country_id] = @resort.country_id
      redirect_to(resorts_path, notice: t('notices.created'))
    else
      render action: 'new'
    end
  end

  def edit
    set_image_mode

    @interhome_place_resort = InterhomePlaceResort.new(resort_id: @resort.id)
    @pv_place_resort = PvPlaceResort.new(resort_id: @resort.id)
  end

  def update
    if @resort.update_attributes(resort_params)
      redirect_to(edit_admin_resort_path(@resort), notice: t('notices.saved'))
    else
      @interhome_place_resort = InterhomePlaceResort.new(resort_id: @resort.id)
      render action: 'edit'
    end
  end

  def destroy
    @resort.destroy
    redirect_to(admin_resorts_path)
  end

  def edit_page
    page_name = params[:page_name]
    if Resort.page_names.include?(page_name)
      @resort.create_page(page_name) unless @resort.has_page?(page_name)
      redirect_to edit_page_path(@resort.page(page_name))
    end
  end

  protected

    def set_resort
      @resort = Resort.find_by(id: params[:id])
      redirect_to(admin_resorts_path, notice: t('resorts_controller.not_found')) unless @resort
    end

    def set_image_mode
      session[:image_mode] = 'resort'
      session[:resort_id] = @resort.id
    end

    def resort_params
      params.require(:resort).permit(:altitude_m, :apres_ski, :babysitting_services, :beginner,
        :black, :blue, :cable_car, :chair, :country_id, :creche,
        :cross_country_km, :drags, :expert, :family, :feature, :featured, :funicular,
        :gallery_content, :glacier_skiing, :gondola, :green, :heli_skiing,
        :info, :insider_view, :intermediate,
        :introduction, :living_in, :local_area, :longest_run_km,
        :mountain_restaurants, :name, :off_piste, :owning_a_property_in,
        :piste_map_content, :railways, :red, :region_id, :season, :ski_area_km,
        :slope_direction, :snowboard_parks, :summer_only,
        :summer_skiing, :top_lift_m, :weather_code, :visible, :visiting)
    end
end
