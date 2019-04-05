class AdvertsController < ApplicationController
  before_action :user_required
  before_action :prepare_basket, only: [:basket, :place_order]

  def my
    @window_groups = WindowGroups.new
    @user = if params[:user_id] && admin?
      User.find(params[:user_id])
    else
      current_user
    end

    if @user.advertises_through_windows?
      @user.delete_old_windows
      @user.windows.each {|w| @window_groups << w}
    end

    @rentals = @user.properties_for_rent
    @sales = @user.properties_for_sale
    @directory_adverts = @user.directory_adverts
  end

  def basket
  end

  def update_basket_contents
    apply_coupon_code && return unless params[:code].blank?

    update_durations unless params[:months].nil?
    remove_advert if params[:remove_advert]

    # TODO: Move 'place_order' from GET to POST
    redirect_to(action: "place_order") && return if params[:place_order]

    if params[:empty_basket]
      current_user.empty_basket
      remove_windows_from_basket
      flash[:notice] = t("adverts_controller.notices.basket_emptied")
    else
      flash[:notice] = t("adverts_controller.notices.basket_updated")
    end
    redirect_to basket_path
  end

  def place_order
    # Delete previous unpaid order, if any
    if session[:order_id] && (@order = Order.find_by(id: session[:order_id]))
      @order.destroy if @order.status == Order::WAITING_FOR_PAYMENT
    end

    @order = Order.new
    @order.currency = Currency.gbp

    copy_user_details_to_order

    @lines.each do |line|
      if line.advert
        advert_id = line.advert.id
        country_id = line.advert.object.resort.country.id
        resort_id = line.advert.object.resort.id
      else
        advert_id = country_id = resort_id = nil
      end

      coupon_id = line.coupon ? line.coupon.id : nil

      @order.order_lines << OrderLine.new(
        advert_id: advert_id,
        description: line.order_description,
        amount: line.price,
        coupon_id: coupon_id,
        country_id: country_id,
        resort_id: resort_id,
        windows: line.windows
      )

      if line.pay_monthly?
        @order.pay_monthly = true
        @order.first_payment = line.first_payment
        @order.subsequent_payments = line.subsequent_payments
        if @current_user.pays_vat?
          @order.first_payment += @w.vat_for(line.first_payment)
          @order.subsequent_payments += @w.vat_for(line.subsequent_payments)
        end
      end
    end

    @order.total = @total
    @order.tax_amount = @tax_amount
    @order.tax_description = current_user.tax_description
    @order.sterling_in_euros = Currency.sterling_in_euros
    @order.status = if @order.total == 0
      Order::PAYMENT_NOT_REQUIRED
    else
      Order::WAITING_FOR_PAYMENT
    end
    @order.save!

    session[:order_id] = @order.id

    if @order.total == 0
      redirect_to controller: "payments", action: "complete_payment_not_required"
    else
      redirect_to controller: "orders", action: "select_payment_method"
    end
  end

  def destroy
    @advert = Advert.find_by(id: params[:id], user_id: @current_user.id, starts_at: nil)
    if @advert
      @advert.destroy
      notice = t("notices.advert_removed")
    end
    redirect_to basket_path, notice: notice
  end

  def buy_windows
    @window_base_prices = WindowBasePrice.order("quantity")
  end

  def add_windows_to_basket
    session[:windows_in_basket] = params[:quantity]
    redirect_to basket_path
  end

  def delete_all_new_advertisables
    current_user.new_advertisables.each {|a| a.destroy}
    redirect_to my_adverts_path, notice: "All new adverts have been deleted."
  end

  protected

  def prepare_basket
    current_user.remove_expired_coupon

    @basket = Basket.new(windows: windows_in_basket, user: current_user)
    @basket.prepare

    @lines = @basket.lines
    @total = @subtotal = @basket.subtotal

    @subtotal = @total

    if current_user.pays_vat?
      @tax_amount = @w.vat_for(@subtotal)
      @total += @tax_amount
    else
      @tax_amount = 0
    end
  end

  def windows_in_basket
    if session[:windows_in_basket] && WindowBasePrice.find_by(quantity: session[:windows_in_basket]).nil?
      session[:windows_in_basket] = nil
    else
      session[:windows_in_basket]
    end
  end

  def apply_coupon_code
    coupon = Coupon.find_by(code: params[:code])
    if coupon
      if coupon.expired?
        notice = I18n.t("coupons_controller.coupon_code_expired")
      else
        @current_user.coupon = coupon
        @current_user.save
        notice = I18n.t("coupons_controller.coupon_code_applied")
      end
    else
      notice = I18n.t("coupons_controller.coupon_code_not_recognised")
    end
    redirect_to basket_path, notice: notice
  end

  def update_durations
    params[:months].each_pair do |id, months|
      months = months.to_i
      advert = Advert.find_by(id: id, user_id: @current_user.id)
      if advert
        if advert.object.valid_months.include? months
          advert.months = months
          advert.save
        end
      end
    end
  end

  def remove_advert
    params[:remove_advert].each_key do |id|
      if id == "windows"
        session[:windows_in_basket] = nil
      else
        Advert.destroy_all(id: id, user_id: @current_user.id)
      end
    end
  end

  def remove_windows_from_basket
    session[:windows_in_basket] = nil
  end

  def copy_user_details_to_order
    @order.user_id = current_user.id
    @order.address = "#{current_user.billing_street}\n#{current_user.billing_locality}\n" \
      "#{current_user.billing_city}\n#{current_user.billing_county}\n"
    @order.postcode = current_user.billing_postcode
    @order.country_id = current_user.billing_country_id
    @order.phone = current_user.phone
    @order.email = current_user.email
    @order.name = current_user.name
    @order.customer_vat_number = current_user.vat_number
  end
end
