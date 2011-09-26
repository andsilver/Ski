class BasketLine
  attr_accessor :advert, :coupon, :description, :price, :windows

  def initialize
    @windows = 0
  end

  def order_description
    if @advert
      if @coupon
        "#{@advert.months.to_s} month(s): #{@advert} [#{@description}]"
      else
        "#{@advert.months.to_s} month(s): #{@advert}"
      end
    else
      @description
    end
  end

  def pay_monthly?
    windows.to_i > 0
  end

  def first_payment
    price - 11 * (price / 12)
  end

  def subsequent_payments
    price / 12
  end
end
