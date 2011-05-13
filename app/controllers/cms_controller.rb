class CmsController < ApplicationController
  before_filter :admin_required
  before_filter :no_browse_menu

  def index
  end
end
