class AvailabilityResponse < InterhomeResponse
  def start_date
    result['StartDate'][0]
  end

  def end_date
    result['EndDate'][0]
  end

  def state
    result['State'][0]
  end

  def change
    result['Change'][0]
  end

  def minimum_stay
    result['MinimumStay'][0]
  end

  def result
    response['AvailabilityResult'][0]
  end

  def response
    @data['Body'][0]['AvailabilityResponse'][0]
  end
end
