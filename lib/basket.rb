class Basket
  attr_accessor :lines

  def initialize(options)
    @lines = []
    @user = options[:user]
    @windows = options[:windows]
  end

  def prepare
    add_line_for_windows(@windows)
    add_lines_for_adverts(@user.adverts_in_basket)
    apply_price_override
  end

  def add_line_for_windows(quantity)
    return unless quantity

    line = BasketLine.new
    line.description = "#{quantity} property windows"
    line.price = WindowBasePrice.find_by(quantity: quantity).price * 100
    line.windows = quantity
    @lines << line
  end

  def add_lines_for_adverts(adverts)
    total_adverts = @user.adverts_so_far
    advert_number = {
      directory_advert: @user.directory_adverts_so_far,
      property: @user.property_adverts_so_far,
    }

    adverts.each do |advert|
      # Remove advert types that are no longer valid from the basket
      if advert.virtual_type.nil?
        advert.destroy
        next
      end

      advert_number[advert.virtual_type] += 1
      total_adverts += 1
      line = BasketLine.new
      line.description = line.advert = advert
      begin
        line.price = advert.price(advert_number[advert.virtual_type])
      rescue
        advert.destroy
        next
      end
      @lines << line
      if @user.coupon && @user.coupon.number_of_adverts >= total_adverts
        discount_line = BasketLine.new
        discount_line.advert = advert
        discount_line.coupon = @user.coupon
        discount_line.price = -(@user.coupon.percentage_off / 100.0) * line.price
        discount_line.description = @user.coupon.code + " #" + total_adverts.to_s
        @lines << discount_line
      end
    end
  end

  def apply_price_override
    return unless @user.apply_price_override?
    override_line = BasketLine.new
    override_line.description = "Price override €#{@user.price_override}"
    override_line.price = @user.price_override * 100 - subtotal
    @lines << override_line
  end

  def subtotal
    @lines.inject(0) {|r, l| r + l.price}
  end
end
