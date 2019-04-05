# frozen_string_literal: true

class WebsitesController < ApplicationController
  before_action :admin_required
  before_action :find_website, only: [:edit, :edit_prices, :update]

  layout "admin"

  def edit
  end

  def edit_prices
  end

  def update
    if @website.update_attributes(website_params)
      redirect_to(edit_website_path(@website), notice: t("notices.saved"))
    else
      render "edit"
    end
  end

  protected

  def find_website
    @website = @w
  end

  def website_params
    params.require(:website).permit(
      :contact_details, :directory_advert_price,
      :featured_property_ids, :home_content, :privacy_policy,
      :resources_banner_html, :sidebar_html, :start_page_content,
      :skip_payment, :terms,
      :vat_rate, :worldpay_active, :worldpay_installation_id,
      :worldpay_payment_response_password, :worldpay_test_mode
    )
  end
end
