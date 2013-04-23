class ResortSummariesTable
  include ActionView::Helpers::UrlHelper

  def initialize(country)
    @country = country
  end

  def headers
    [
      I18n.t('resort'),
      I18n.t('resorts_controller.facts.altitude'),
      I18n.t('resorts_controller.facts.top_lift'),
      I18n.t('resorts_controller.facts.ski_area'),
      I18n.t('resorts_controller.facts.nearest_airport'),
      I18n.t('resorts_controller.facts.distance')
    ]
  end

  def rows
    rows = []
    @country.resorts.map {|r| [r, r.altitude_m, r.top_lift_m, r.ski_area_km, r.nearest_airport ? r.nearest_airport.name : nil, r.airport_distances.any? ? r.airport_distances.first.distance_km : nil ]}
  end
end
