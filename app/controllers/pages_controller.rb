class PagesController < ApplicationController
  before_filter :admin_required, except: [:show]
  before_filter :find_page, only: [:edit, :update, :destroy]
  before_filter :no_browse_menu

  def index
    @pages = Page.order('path')
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to(pages_path, notice: t('notices.created'))
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @page.update_attributes(page_params)
      redirect_to(edit_page_path(@page), notice: t('notices.saved'))
    else
      render 'edit'
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_path, notice: t('notices.deleted')
  end

  def show
    @page = Page.find_by_path("/pages/#{params[:id]}")
    not_found and return unless show_page?
    @content = Liquid::Template.parse(@page.content).render('buying_guides' => BuyingGuide.all)
  end

  protected

  def show_page?
    @page && (@page.visible? || admin?)
  end

  def find_page
    @page = Page.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:banner_advert_html, :content, :description, :footer_id, :keywords, :path, :title, :visible)
  end
end
