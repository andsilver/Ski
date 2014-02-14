class Admin::RegionsController < ApplicationController
  before_action :admin_required
  before_action :find_region, only: [:edit, :update, :destroy, :edit_page]
  layout 'admin'

  include EditRelatedPages
  def klass; Region; end
  def object; @region; end

  def index
    @regions = Region.order('name')
  end

  def new
    @region = Region.new
  end

  def create
    @region = Region.new(region_params)

    if @region.save
      redirect_to(admin_regions_path, notice: t('notices.created'))
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @region.update_attributes(region_params)
      redirect_to(edit_admin_region_path(@region), notice: t('notices.saved'))
    else
      render 'edit'
    end
  end

  def destroy
    @region.destroy
    redirect_to admin_regions_path, notice: t('notices.deleted')
  end

  protected

    def find_region
      @region = Region.find_by(slug: params[:id])
    end

    def region_params
      params.require(:region).permit(:country_id, :info, :name, :slug)
    end
end
