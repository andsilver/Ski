class Order < ActiveRecord::Base
  validates :address, :country, :email, :name, :phone, :status, :total, :user, presence: true

  before_create :create_order_number

  belongs_to :country
  belongs_to :user
  belongs_to :currency

  has_many :order_lines, dependent: :delete_all

  # Order statuses
  WAITING_FOR_PAYMENT   = 1
  PAYMENT_RECEIVED      = 2
  PAYMENT_ON_ACCOUNT    = 3
  PAYMENT_NOT_REQUIRED  = 4

  def self.from_session session
    session[:order_id] ? find_by(id: session[:order_id]) : nil
  end

  def status_description
    {
      WAITING_FOR_PAYMENT => "Waiting for payment",
      PAYMENT_RECEIVED => "Payment received",
      PAYMENT_ON_ACCOUNT => "Payment on account",
      PAYMENT_NOT_REQUIRED => "Payment not required",
    }[status]
  end

  def payment_received?
    status == Order::PAYMENT_RECEIVED || status == Order::PAYMENT_NOT_REQUIRED
  end

  # create an order number
  # order numbers include date but are not sequential so as to prevent competitor analysis of sales volume
  def create_order_number
    alpha = %w[0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]
    # try a short order number first
    # in case of collision, increase length of order number
    (4..10).each do |length|
      self.order_number = Time.now.strftime("%Y%m%d-")
      length.times {self.order_number += alpha[rand 36]}
      existing_order = Order.find_by(order_number: order_number)
      return if existing_order.nil?
    end
  end

  # http://alt.pluralsight.com/wiki/default.aspx/Craig/BirthdayProblemCalculator.html
  # this method is not used
  # k = number of orders in a day
  # n = number of possible values for order number
  def probability_of_collision k, n
    1 - Math.exp((-k**2.0) / (2.0 * n))
  end
end
