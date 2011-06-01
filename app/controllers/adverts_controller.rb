class AdvertsController < ApplicationController
  before_filter :no_browse_menu
  before_filter :user_required
  before_filter :prepare_basket, :only => [:basket, :place_order]

  def my
    @rentals = @current_user.properties_for_rent
    @sales = @current_user.properties_for_sale
    @banner_adverts = @current_user.banner_adverts
    @directory_adverts = @current_user.directory_adverts
  end

  def basket
  end

  def update_basket_contents
    update_durations unless params[:months].nil?
    remove_advert if params[:remove_advert]
    redirect_to :action => 'place_order' and return if params[:place_order]
    redirect_to basket_path, :notice => t('notices.basket_updated')
  end

  def place_order
    # Delete previous unpaid order, if any
    if session[:order_id] && @order = Order.find_by_id(session[:order_id])
      @order.destroy if @order.status == Order::WAITING_FOR_PAYMENT
    end

    @order = Order.new

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
        :advert_id => advert_id,
        :description => line.order_description,
        :amount => line.price,
        :coupon_id => coupon_id,
        :country_id => country_id,
        :resort_id => resort_id
      )
    end

    @order.total = @total
    @order.status = Order::WAITING_FOR_PAYMENT
    @order.save!

    session[:order_id] = @order.id
    redirect_to :controller => 'orders', :action => 'select_payment_method'
  end

  def destroy
    @advert = Advert.find_by_id_and_user_id_and_starts_at(params[:id], @current_user.id, nil)
    if @advert
      @advert.destroy
      notice = t('notices.advert_removed')
    end
    redirect_to basket_path, :notice => notice
  end

  protected

  def prepare_basket
    @lines = Array.new
    @total = 0

    total_adverts = @current_user.adverts_so_far
    advert_number = Hash.new
    advert_number = {
      :banner_advert => @current_user.banner_adverts_so_far,
      :directory_advert => @current_user.directory_adverts_so_far,
      :property => @current_user.property_adverts_so_far
    }
    @current_user.adverts_in_basket.each do |advert|
      advert_number[advert.type] += 1
      total_adverts += 1
      line = BasketLine.new
      line.description = line.advert = advert
      line.price = advert.price(advert_number[advert.type])
      @lines << line
      @total += line.price
      if @current_user.coupon && @current_user.coupon.free_adverts >= total_adverts
        discount_line = BasketLine.new
        discount_line.advert = advert
        discount_line.coupon = @current_user.coupon
        discount_line.price = -1 * line.price
        discount_line.description = @current_user.coupon.code + ' #' + total_adverts.to_s
        @lines << discount_line
        @total -= line.price
      end
    end
  end

  def update_durations
    params[:months].each_pair do |id,months|
      months = months.to_i
      advert = Advert.find_by_id_and_user_id(id, @current_user.id)
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
      Advert.destroy_all(:id => id, :user_id => @current_user.id)
    end
  end

  def copy_user_details_to_order
    @order.user_id = @current_user.id
    @order.address = @current_user.billing_street + "\n" +
      @current_user.billing_locality + "\n" +
      @current_user.billing_city + "\n" +
      @current_user.billing_county + "\n"
    @order.postcode = @current_user.billing_postcode
    @order.country_id = @current_user.billing_country_id
    @order.phone = @current_user.phone
    @order.email = @current_user.email
    @order.name = @current_user.name
  end
end
