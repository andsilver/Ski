class CmsController < ApplicationController
  before_filter :admin_required
  before_filter :no_browse_menu

  def index
    @page_title = @heading_a = t('cms_controller.cms')
  end

  def management_information
    @page_title = @heading_a = t('cms_controller.management_information')
  end

  def gross_sales_analysis
    @page_title = @heading_a = t('cms_controller.gross_sales_analysis')
  end
end
