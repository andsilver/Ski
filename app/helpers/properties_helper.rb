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

  def distance_options
    [
      ["< 100m", 100],
      ["< 200m", 200],
      ["< 300m", 300],
      ["< 400m", 400],
      ["< 500m", 500],
      ["< 600m", 600],
      ["< 700m", 700],
      ["< 800m", 800],
      ["< 900m", 900],
      ["< 1,000m", 1000],
      ["1,000m+", 1001]
    ]
  end

  def floor_area_options
    [
      [30, 30],
      [35, 35],
      [40, 40],
      [45, 45],
      [50, 50],
      [55, 55],
      [60, 60],
      [65, 65],
      [70, 70],
      [75, 75],
      [80, 80],
      [85, 85],
      [90, 90],
      [95, 95],
      [100, 100],
      [110, 110],
      [120, 120],
      [130, 130],
      [140, 140],
      [150, 150],
      [160, 160],
      [170, 170],
      [180, 180],
      [190, 190],
      [200, 200],
      [210, 210],
      [220, 220],
      [230, 230],
      [240, 240],
      [250, 250],
      [260, 260],
      [270, 270],
      [280, 280],
      [290, 290],
      [300, 300],
      [320, 320],
      [340, 340],
      [360, 360],
      [380, 380],
      [400, 400],
      [420, 420],
      [440, 440],
      [460, 460],
      [480, 480],
      [500, 500]
    ]
  end

  def plot_size_options
    [
      [30, 30],
      [50, 50],
      [75, 75],
      [100, 100],
      [125, 125],
      [150, 150],
      [175, 175],
      [200, 200],
      [225, 225],
      [250, 250],
      [275, 275],
      [300, 300],
      [350, 350],
      [400, 400],
      [450, 450],
      [500, 500],
      [600, 600],
      [700, 700],
      [800, 800],
      [900, 900],
      [1000, 1000],
      [1200, 1200],
      [1400, 1400],
      [1600, 1600],
      [1800, 1800],
      [2000, 2000],
      [2250, 2250],
      [2500, 2500],
      [2750, 2750],
      [3000, 3000],
      [3500, 3500],
      [4000, 4000],
      [5000, 5000],
      [6000, 6000],
      [7000, 7000],
      [8000, 8000],
      [9000, 9000],
      [10000, 10000],
      [11000, 11000],
      [12000, 12000],
      [13000, 13000],
      [14000, 14000],
      [15000, 15000]
    ]
  end
end
