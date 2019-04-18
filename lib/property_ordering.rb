module PropertyOrdering
  # Return the order preference selected by the user
  def selected_order(whitelist:, sort_method:)
    whitelist.include?(sort_method) ? sort_method : whitelist.first
  end

  def order_whitelist
    ["normalised_weekly_rent_price ASC", "normalised_weekly_rent_price DESC",
     "sleeping_capacity ASC", "number_of_bedrooms ASC",]
  end

  def for_sale_order_whitelist
    ["normalised_sale_price ASC", "normalised_sale_price DESC",
     "number_of_bathrooms ASC", "number_of_bedrooms ASC",]
  end
end
