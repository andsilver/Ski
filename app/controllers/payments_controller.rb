class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:worldpay_callback]

  FAILURE_MESSAGE = "Some information was incorrect and your payment may not have gone through properly. Please contact us."

  def worldpay_callback
    @payment = Payment.new
    @payment.service_provider = "WorldPay"
    @payment.installation_id = params[:instId]
    @payment.cart_id = params[:cartId]
    @payment.description = params[:desc]
    @payment.amount = params[:amount]
    @payment.currency = params[:currency]
    @payment.test_mode = (params[:testMode] != "0")
    @payment.name = params[:name]
    @payment.address = params[:address]
    @payment.postcode = params[:postcode]
    @payment.country = params[:country]
    @payment.telephone = params[:tel]
    @payment.fax = params[:fax]
    @payment.email = params[:email]
    @payment.transaction_id = params[:transId]
    @payment.transaction_status = (params[:transStatus] && (params[:transStatus] == "Y"))
    @payment.transaction_time = params[:transTime]
    @payment.raw_auth_message = params[:rawAuthMessage]
    @payment.accepted = false # for now

    @payment.futurepay_id = params[:futurePayId] unless params[:futurePayId].nil?

    @payment.save # this first save is for safety

    if params[:transStatus].nil? || (params[:transStatus] != "Y")
      @message = t("payments_controller.no_payment_made")
    elsif !@w.skip_payment? && (params[:callbackPW].nil? || (params[:callbackPW] != @w.worldpay_payment_response_password))
      @message = FAILURE_MESSAGE
    elsif params[:cartId].nil?
      @message = FAILURE_MESSAGE
    elsif params[:testMode] && !@w.worldpay_test_mode && (params[:testMode] != "0") && params[:futurePayId].nil?
      @message = FAILURE_MESSAGE
    else
      @message = t("payments_controller.payment_received")
      @payment.accepted = true
      complete_order
    end
    @payment.save
    render layout: false
  end

  def complete_payment_not_required
    order = Order.find(session[:order_id])
    if order.payment_received?
      make_adverts_live(order)
    end
    redirect_to controller: "orders", action: "latest_receipt"
  end

  protected

  def complete_order
    order = Order.find_by(order_number: @payment.cart_id)
    raise "Order not found for #{@payment.cart_id}" unless order
    update_order order
  end

  def update_order order
    order.status = Order::PAYMENT_RECEIVED
    order.save
    @payment.order_id = order.id
    make_adverts_live(order)
    # OrderNotifier.deliver_notification @w, order
  end

  def make_adverts_live(order)
    order.order_lines.each do |line|
      if line.advert
        line.advert.start_and_save! unless line.coupon
      end
      if line.windows > 0
        Advert.activate_windows_for_user(line.windows, order, initial_window_months(order))
      end
    end
    session[:windows_in_basket] = nil
  end

  # Returns the number of months the window should be initially activated for
  # based on the order. Orders with a total of 0 are assumed to have been
  # negotiated for a yearly fee offline.
  def initial_window_months(order)
    order.total > 0 ? 1 : 12
  end
end
