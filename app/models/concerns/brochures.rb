module Brochures
  extend ActiveSupport::Concern

  included do
    has_many :holiday_type_brochures, dependent: :delete_all, as: :brochurable
    has_many :holiday_types, through: :holiday_type_brochures
  end

  def theme
    holiday_types.first.try(:slug)
  end

  def themes
    holiday_types.map {|ht| ht.slug }
  end

  def breadcrumbs
    crumbs = {}
    if theme && country.themes.include?(theme)
      crumbs[holiday_types.first] = holiday_types.first
      crumbs["#{holiday_types.first} in #{country}"] = Rails.application.routes.url_helpers.holiday_type_brochure_path(place_type: "countries", place_slug: country.slug, holiday_type_slug: theme)
    end

    if respond_to?(:region) && region
      crumbs[region.name] = region
    end

    crumbs[name] = self
    crumbs
  end
end
