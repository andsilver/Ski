class OrdersController < ApplicationController
  before_action :user_required
  before_action :require_order_from_session, only: [:select_payment_method, :latest_receipt]
  before_action :find_order, only: [:receipt, :invoice]

  before_action :admin_required, only: [:index, :show, :destroy]
  layout "admin", only: [:index, :show, :destroy]

  def index
    @orders = Order.order("created_at DESC")
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy
    redirect_to orders_path, notice: t("notices.deleted")
  end

  def select_payment_method
  end

  def show
    @order = Order.find(params[:id])
  end

  def receipt
  end

  def invoice
    invoice = Invoice.new(@order)
    invoice.render
    send_file(invoice.filename)
  end

  def latest_receipt
    redirect_to(basket_path) && return unless @order.payment_received? || (@order.status == Order::PAYMENT_ON_ACCOUNT)
    @google_ecommerce_tracking = true
    render "receipt"
  end

  def receipts
    @orders = current_user.orders_with_receipts
  end

  protected

  def require_order_from_session
    @order = Order.from_session session
    if @order.nil?
      redirect_to(basket_path, notice: t("orders_controller.no_order_found"))
    end
  end

  def find_order
    @order = if admin?
      Order.find_by(id: params[:id])
    else
      Order.find_by(id: params[:id], user_id: current_user.id)
    end

    if @order.nil?
      redirect_to(receipts_orders_path, notice: t("orders_controller.receipt_not_found"))
    end
  end
end
