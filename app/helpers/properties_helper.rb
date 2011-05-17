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
end
