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
end
