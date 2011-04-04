class WebsitesController < ApplicationController
  before_filter :admin_required
  before_filter :find_website, :only => [:edit, :update]

  def edit
  end

  def update
    if @website.update_attributes(params[:website])
      redirect_to(edit_website_path(@website), :notice => 'Saved')
    else
      render "edit"
    end
  end

  protected

  def find_website
    @website = @w
  end
end
