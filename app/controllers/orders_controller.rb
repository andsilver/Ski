class OrdersController < ApplicationController
  before_filter :require_order, :only => [:select_payment_method, :receipt]

  def select_payment_method
  end

  def receipt
    redirect_to basket_path and return unless (@order.payment_received? or @order.status==Order::PAYMENT_ON_ACCOUNT)
    @google_ecommerce_tracking = true
  end

  protected

  # get valid order from current session or send user back to their basket
  def require_order
    @order = Order.from_session session
    if @order.nil?
      redirect_to(basket_path, :notice => "We couldn't find an order for you.")
    end
  end
end
