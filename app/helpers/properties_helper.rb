module PropertiesHelper
  def property_search_filters filters
    html = ''
    filters.each do |f|
      param = 'filter_' + f.to_s
      html += '<label class="filter"><input'
      html += ' checked' if params[param]=='on'
      html += ' type="checkbox" name="filter_' + f.to_s + '" onchange="this.form.submit()">'
      html += I18n.t('properties.filters.' + f.to_s) + '</label>'
    end
    html
  end

  def feature_tick ticked, label
    html = ''
    if ticked
      html += '<div class="ticked_feature"><span>Has</span>'
    else
      html += '<div class="unticked_feature"><span>Does not have</span>'
    end
    (html + ' ' + label + '</div>').html_safe
  end

  def count_properties_for_rent_in resort
    count_properties_in resort, :for_sale, 0
  end

  def count_properties_for_sale_in resort
    count_properties_in resort, :for_sale, 1
  end

  def count_new_developments_in resort
    count_properties_in resort, :new_development, 1
  end

  def count_properties_in resort, attribute, value
    @conditions = PropertiesController::CURRENTLY_ADVERTISED.dup
    @conditions[0] += " AND resort_id = #{resort.id}"
    @conditions[0] += " AND #{attribute.to_s} = #{value}"
    "(#{Property.where(@conditions).count})"
  end
end
