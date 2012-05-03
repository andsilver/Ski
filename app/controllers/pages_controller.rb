class PagesController < ApplicationController
  before_filter :admin_required
  before_filter :find_page, :only => [:edit, :update, :destroy]
  before_filter :no_browse_menu

  def index
    @pages = Page.all(:order => 'path')
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])

    if @page.save
      redirect_to(pages_path, :notice => t('notices.created'))
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @page.update_attributes(params[:page])
      redirect_to(pages_path, :notice => t('notices.saved'))
    else
      render "edit"
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_path, :notice => t('notices.deleted')
  end

  def resources
    @buying_guides = BuyingGuide.all
  end

  protected

  def find_page
    @page = Page.find(params[:id])
  end
end
