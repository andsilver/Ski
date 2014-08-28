class PropertyDecorator < Draper::Decorator
  delegate_all

  include Rails.application.routes.url_helpers

  def nearest_lift
    metres_from_lift == 1001 ? '> 1km' : "#{metres_from_lift}m"
  end

  def breadcrumbs
    crumbs = resort.breadcrumbs

    if new_development?
      crumbs[I18n.t('new_developments')] = resort_property_new_developments_path(resort)
    elsif for_sale?
      crumbs[I18n.t('for_sale')] = resort_property_sale_path(resort)
    elsif for_rent?
      crumbs[I18n.t('for_rent')] = resort_property_rent_path(resort)
    elsif hotel?
      crumbs[I18n.t('hotels')] =  resort_property_hotels_path(resort)
    end

    crumbs
  end

  def contact_breadcrumbs
    breadcrumbs.merge(name => self)
  end

  # Returns a truncated property name for use where space is limited.
  def truncated_name
    name.length <= 50 ? name : "#{name[0...50]}..."
  end
end
