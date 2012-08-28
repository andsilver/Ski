class PricesResponse < InterhomeResponse
  def price
    prices[0]['PricesPriceItem'][0]['Price1'][0]
  end

  def prices
    result['Prices']
  end

  def result
    response['PricesResult'][0]
  end

  def response
    @data['Body'][0]['PricesResponse'][0]
  end
end
