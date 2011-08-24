class PaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:worldpay_callback, :cardsave_callback]

  before_filter :admin_required, :only => [:index, :show]

  before_filter :no_browse_menu

  FAILURE_MESSAGE = 'Some information was incorrect and your payment may not have gone through properly. Please contact us.'

  def index
    @payments = Payment.all(:order => 'created_at desc')
  end

  def show
    @payment = Payment.find(params[:id])
  end

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
      @message = t('payments_controller.no_payment_made')
    elsif !@w.skip_payment? and (params[:callbackPW].nil? or params[:callbackPW] != @w.worldpay_payment_response_password)
      @message = FAILURE_MESSAGE
    elsif params[:cartId].nil?
      @message = FAILURE_MESSAGE
    elsif params[:testMode] and !@w.worldpay_test_mode and params[:testMode] != '0'
      @message = FAILURE_MESSAGE      
    else
      @message = t('payments_controller.payment_received')
      @payment.accepted = true
      complete_order
    end
    @payment.save
    render :layout => false
  end

  def cardsave_callback
    @payment = Payment.new
    @payment.service_provider = 'CardSave'
    @payment.installation_id = params[:MerchantID]
    @payment.amount = params[:Amount]
    @payment.currency = params[:CurrencyCode]
    @payment.cart_id = params[:OrderID]
    @payment.transaction_status = (params[:StatusCode] and params[:StatusCode]=='0')
    @payment.transaction_time = params[:TransactionDateTime]
    @payment.accepted = false # for now
    @payment.save # this first save is for safety

    if cardsave_hash_matches?
      if params[:StatusCode]=='0'
        @message = t('payments_controller.payment_received')
        @payment.accepted = true
        complete_order
      elsif params[:StatusCode]=='5'
        @message = t('payments_controller.payment_declined')
      elsif params[:StatusCode]=='30'
        @message = t('payments_controller.processing_error')
      else
        @message = t('payments_controller.unconfirmed')
      end
    else
      @message = t('payments_controller.failure_validating_payment')
    end
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
        line.advert.start_and_save! unless line.coupon
      end
      if line.windows > 0
        Advert.activate_windows_for_user(line.windows, @payment.order.user)
      end
    end
  end
end
