# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :admin_required, except: [:show]
  layout "admin", except: [:show]

  before_action :find_page, only: [:edit, :update, :destroy, :copy]

  def index
    @pages = Page.order("path")
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to(pages_path, notice: t("notices.created"))
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @page.update_attributes(page_params)
      redirect_to(edit_page_path(@page), notice: t("notices.saved"))
    else
      render "edit"
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_path, notice: t("notices.deleted")
  end

  def show
    @page = Page.find_by(path: "/pages/#{params[:id]}")
    not_found && return unless show_page?
    @content = Liquid::Template.parse(@page.content).render("buying_guides" => BuyingGuide.all)
  end

  def copy
    @page = @page.dup
    render "new"
  end

  protected

  def show_page?
    @page && (@page.visible? || admin?)
  end

  def find_page
    @page = Page.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:content, :description, :footer_id, :header_snippet_name, :keywords, :path, :sidebar_snippet_name, :title, :visible)
  end
end
