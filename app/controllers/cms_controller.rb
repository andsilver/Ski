class CmsController < ApplicationController
  before_filter :admin_required
  before_filter :no_browse_menu

  def index
    @heading_a = t('cms_controller.cms')
  end

  def management_information
  end

  def gross_sales_analysis
    @heading_a = t('cms_controller.gross_sales_analysis')
  end
end
