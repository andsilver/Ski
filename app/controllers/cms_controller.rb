class CmsController < ApplicationController
  before_action :admin_required

  layout "admin"

  def index
    @heading_a = t("cms_controller.cms")
    default_page_title(@heading_a)
  end

  def guide
    @heading_a = t("cms_controller.guide")
    default_page_title(@heading_a)
  end

  def management_information
    @heading_a = t("cms_controller.management_information")
    default_page_title(@heading_a)
  end

  def gross_sales_analysis
    @heading_a = t("cms_controller.gross_sales_analysis")
    default_page_title(@heading_a)
  end
end
