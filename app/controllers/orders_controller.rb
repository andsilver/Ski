class OrdersController < ApplicationController
  before_filter :user_required
  before_filter :no_browse_menu
  before_filter :require_order_from_session, :only => [:select_payment_method, :latest_receipt]

  before_filter :admin_required, :only => [:index]

  def index
    @orders = Order.all
  end

  def select_payment_method
  end

  def receipt
    @order = Order.find_by_id_and_user_id(params[:id], @current_user.id)
    if @order.nil?
      redirect_to(receipts_orders_path, :notice => "We couldn't find that order.")
    end
  end

  def latest_receipt
    redirect_to basket_path and return unless (@order.payment_received? or @order.status==Order::PAYMENT_ON_ACCOUNT)
    @google_ecommerce_tracking = true
    render "receipt"
  end

  def receipts
    @orders = @current_user.orders_with_receipts
  end

  protected

  def require_order_from_session
    @order = Order.from_session session
    if @order.nil?
      redirect_to(basket_path, :notice => "We couldn't find an order for you.")
    end
  end
end
