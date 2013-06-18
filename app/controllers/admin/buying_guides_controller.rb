class Admin::BuyingGuidesController < ApplicationController
  before_action :admin_required
  layout 'admin'

  before_action :set_buying_guide, only: [:edit, :update, :destroy]

  def index
    @buying_guides = BuyingGuide.all
  end

  def new
    @buying_guide = BuyingGuide.new
  end

  def create
    @buying_guide = BuyingGuide.new(buying_guide_params)

    if @buying_guide.save
      redirect_to(buying_guides_path, notice: t('notices.created'))
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @buying_guide.update_attributes(buying_guide_params)
      redirect_to(edit_buying_guide_path(@buying_guide), notice: t('notices.saved'))
    else
      render 'edit'
    end
  end

  def destroy
    @buying_guide.destroy
    redirect_to buying_guides_path
  end

  protected

    def set_buying_guide
      @buying_guide = BuyingGuide.find_by_id(params[:id])
      redirect_to(buying_guides_path) unless @buying_guide
    end

    def buying_guide_params
      params.require(:buying_guide).permit(:content, :country_id)
    end
end
