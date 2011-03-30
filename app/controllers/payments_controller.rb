class PaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:worldpay_callback]

  def worldpay_callback
    @payment = Payment.new
    @payment.service_provider = 'WorldPay'
    @payment.installation_id = params[:instId]
    @payment.cart_id = params[:cartId]
    @payment.description = params[:desc]
    @payment.amount = params[:amount]
    @payment.currency = params[:currency]
    @payment.test_mode = (params[:testMode] != '0')
    @payment.name = params[:name]
    @payment.address = params[:address]
    @payment.postcode = params[:postcode]
    @payment.country = params[:country]
    @payment.telephone = params[:tel]
    @payment.fax = params[:fax]
    @payment.email = params[:email]
    @payment.transaction_id = params[:transId]
    @payment.transaction_status = (params[:transStatus] and params[:transStatus]=='Y')
    @payment.transaction_time = params[:transTime]
    @payment.raw_auth_message = params[:rawAuthMessage]
    @payment.accepted = false # for now
    @payment.save # this first save is for safety

    if params[:transStatus].nil? or params[:transStatus] != 'Y'
      @message = 'No payment was made'
    elsif !WORLDPAY_SIMULATE_PAYMENT and (params[:callbackPW].nil? or params[:callbackPW] != WORLDPAY_PAYMENT_RESPONSE_PASSWORD)
      @message = FAILURE_MESSAGE
    elsif params[:cartId].nil?
      @message = FAILURE_MESSAGE
    elsif params[:testMode] and !WORLDPAY_TEST_MODE and params[:testMode] != '0'
      @message = FAILURE_MESSAGE      
    else
      @message = 'Payment received'
      @payment.accepted = true
      complete_order
    end
    @payment.save
    render :layout => false
  end

  protected

  def complete_order
    order = Order.find_by_order_number(@payment.cart_id)
    raise "Order not found for #{@payment.cart_id}" unless order
    update_order order
  end

  def update_order order
    order.status = Order::PAYMENT_RECEIVED
    order.save
    @payment.order_id = order.id
    make_adverts_live
    #OrderNotifier.deliver_notification @w, order
  end

  def make_adverts_live
    @payment.order.order_lines.each do |line|
      if line.advert
        line.advert.start_and_save!
      end
    end
  end
end