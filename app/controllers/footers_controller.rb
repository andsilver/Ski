class FootersController < ApplicationController
  before_filter :admin_required
  before_filter :find_footer, only: [:edit, :update, :destroy]

  def index
    @footers = Footer.all
  end

  def new
    @footer = Footer.new
  end

  def create
    @footer = Footer.new(footer_params)

    if @footer.save
      redirect_to(footers_path, notice: t('notices.created'))
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @footer.update_attributes(footer_params)
      redirect_to(footers_path, notice: t('notices.saved'))
    else
      render "edit"
    end
  end

  def destroy
    @footer.destroy
    redirect_to footers_path, notice: t('notices.deleted')
  end

  protected

  def find_footer
    @footer = Footer.find(params[:id])
  end

  def footer_params
    params.require(:footer).permit(:content, :name)
  end
end
