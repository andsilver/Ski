class CmsController < ApplicationController
  before_filter :admin_required
  before_filter :no_browse_menu

  def index
  end

  def management_information
  end

  def gross_sales_analysis
    @heading_a = "Gross Sales Analysis"
  end
end
