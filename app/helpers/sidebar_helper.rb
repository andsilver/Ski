module SidebarHelper
  def sidebar_html
    holiday_type_sidebar_html || website_sidebar_html
  end

  def website_sidebar_html
    @w.sidebar_html
  end

  def holiday_type_sidebar_html
    require 'set'
    holiday_types = Set.new
    holiday_types << @holiday_type if @holiday_type
    [@country, @region, @resort].each do |place|
      place.holiday_types.each {|ht| holiday_types << ht} if place
    end
    holiday_types.map {|ht| ht.sidebar_html}.join
  end
end
