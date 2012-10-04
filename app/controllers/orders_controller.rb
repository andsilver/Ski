class OrdersController < ApplicationController
  include ActionView::Helpers::NumberHelper
  include ApplicationHelper

  before_filter :user_required
  before_filter :no_browse_menu
  before_filter :require_order_from_session, only: [:select_payment_method, :latest_receipt]
  before_filter :find_users_order, only: [:receipt, :invoice]

  before_filter :admin_required, only: [:index, :show]

  def index
    @orders = Order.all
  end

  def select_payment_method
  end

  def show
    @order = Order.find(params[:id])
  end

  def receipt
  end

  def invoice
    url_dir = "/invoices/#{@order.hash.to_s}"
    dir = "#{Rails.root.to_s}/public#{url_dir}"
    FileUtils.makedirs(dir)
    filename = "#{dir}/MCF-Invoice-#{@order.order_number}.pdf"
    url_filename = "#{url_dir}/MCF-Invoice-#{@order.order_number}.pdf"

    Prawn::Document.generate(filename, page_size: 'A4') do |pdf|
      spacing = 3
      pdf.font 'fonts/Aller_Lt.ttf'
      pdf.font_size 18
      pdf.text "Invoice number #{@order.order_number}"
      pdf.move_down 24
      pdf.font_size 11
      pdf.text "Invoice created at: #{@order.created_at}"
      pdf.move_down 24

      address_top = 700

      pdf.bounding_box([0, address_top], width: 200, height: 200) do
        pdf.text "My Holiday Home Ventures Ltd\n14 Murrayfield Drive\nEdinburgh\nMidlothian\nEH12 6EB\nUnited Kingdom\nCompany no. SC391840\nVAT no. 111 7832 38", leading: 4
      end

      pdf.bounding_box([300, address_top], width: 200, height: 200) do
        pdf.text("Customer:\n" + @current_user.business_name + "\n" + @order.address.strip + "\n" + @order.postcode + "\n" + @order.country.to_s + "\nCustomer VAT number: #{@order.customer_vat_number}", leading: 4)
      end

      cells = []
      cells << ["Product", "Price"]
      @order.order_lines.each do |line|
        cells << [line.description, euros_from_cents(line.amount)]
      end
      cells << [@order.tax_description, euros_from_cents(@order.tax_amount)]
      cells << ["Order total:", euros_from_cents(@order.total)]

      t = Prawn::Table.new(cells, pdf)
      t.draw

      logopath = "#{Rails.root.to_s}/public/images/my-chalet-finder-logo.png"
      pdf.bounding_box([300, 770], width: 126, height: 22) do
        pdf.image logopath, width: 126, height: 22
      end
    end

    send_file(filename)
  end

  def latest_receipt
    redirect_to basket_path and return unless (@order.payment_received? or @order.status==Order::PAYMENT_ON_ACCOUNT)
    @google_ecommerce_tracking = true
    render 'receipt'
  end

  def receipts
    @orders = @current_user.orders_with_receipts
  end

  protected

  def require_order_from_session
    @order = Order.from_session session
    if @order.nil?
      redirect_to(basket_path, notice: t('orders_controller.no_order_found'))
    end
  end

  def find_users_order
    if admin?
      @order = Order.find_by_id(params[:id])
    else
      @order = Order.find_by_id_and_user_id(params[:id], @current_user.id)
    end

    if @order.nil?
      redirect_to(receipts_orders_path, notice: t('orders_controller.receipt_not_found'))
    end
  end
end
