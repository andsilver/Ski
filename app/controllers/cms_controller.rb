class CmsController < ApplicationController
  before_filter :admin_required
  before_filter :no_browse_menu

  def index
    @heading_a = t('cms_controller.cms')
    default_page_title(@heading_a)
  end

  def management_information
    @heading_a = t('cms_controller.management_information')
    default_page_title(@heading_a)
  end

  def gross_sales_analysis
    @heading_a = t('cms_controller.gross_sales_analysis')
    default_page_title(@heading_a)
  end
end
