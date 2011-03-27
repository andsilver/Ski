module OrdersHelper
  def address_for_worldpay o
    h(o.address).gsub("\n", "&#10;")
  end
end
