module ResortsHelper
  THUMBNAIL_SIZE = 160
  PHOTO_SIZE = 500
  PISTE_MAP_SIZE = 821
  COUNTRIES_DIRECTORY = "#{Rails.root.to_s}/public/countries/"
  RESORTS_DIRECTORY = "#{Rails.root.to_s}/public/resorts/"

  def gallery_thumbnail(resort, filename)
    resort_image(resort, filename, THUMBNAIL_SIZE, 'gallery')
  end

  def gallery_photo(resort, filename)
    resort_image(resort, filename, PHOTO_SIZE, 'gallery')
  end

  def piste_map(resort, filename)
    resort_image(resort, filename, PISTE_MAP_SIZE, 'piste-maps')
  end

  def resort_image(resort, filename, size, sub_dir)
    thumbnails_url = "/resorts/#{@resort.name.parameterize}/#{sub_dir}/#{size}"
    url = "#{thumbnails_url}/#{filename}"
    original_path = "#{Rails.root.to_s}/public/resorts/#{@resort.name.parameterize}/#{sub_dir}/#{filename}"
    path = "#{Rails.root.to_s}/public/#{url}"
    thumbnails_path = "#{Rails.root.to_s}/public/#{thumbnails_url}"

    FileUtils.makedirs(thumbnails_path)

    # create a new image of the required size if it doesn't exist
    unless FileTest.exist?(path)
      begin
        ImageScience.with_image(original_path) do |img|
          if THUMBNAIL_SIZE == size
            Image.new.size_cropped(img, [size, size], path)
          else
            img.thumbnail(size) { |thumb| thumb.save path }
          end
        end
      rescue
        return ''
      end
    end
    url.gsub(' ', '%20')
  end

  # TODO: Refactor
  def header_image_urls
    urls = []

    return urls if @no_header

    if @resort
      if controller.action_name == 'summer_holidays'
        sub_dir = 'summer-headers'
      else
        sub_dir = 'headers'
      end
      resort_images(@resort, sub_dir)

      @images.each do |img|
        urls << "/resorts/#{@resort.name.parameterize}/#{sub_dir}/#{img}"
      end
    end

    if controller.controller_name == 'pages' && controller.action_name == 'show'
      slug = params[:id]
      images_in_directory("#{Rails.root.to_s}/public/pages/#{slug}/headers")
      @images.each do |img|
        urls << "/pages/#{slug}/headers/#{img}"
      end
    end

    if urls.empty? && @country
      if @country.image
        urls << @country.image.url
      end
      country_images(@country, 'headers')
      @images.each do |img|
        urls << "/countries/#{@country.name.parameterize}/headers/#{img}"
      end
    end

    urls.map! {|u| u.gsub(' ', '%20')}
    urls
  end

  def resort_images(resort, sub_dir)
    dir = "#{RESORTS_DIRECTORY}#{resort.name.parameterize}/#{sub_dir}"
    images_in_directory(dir)
  end

  def country_images(country, sub_dir)
    dir = "#{COUNTRIES_DIRECTORY}#{country.name.parameterize}/#{sub_dir}"
    images_in_directory(dir)
  end

  def images_in_directory(dir)
    begin
      @images = Dir.entries(dir).select {|e| e[0..0] != "." && e.include?(".")}
      @images.sort!
    rescue
      @images = []
    end
  end

  def pv_place_codes
    ActiveRecord::Base.connection.execute("SELECT DISTINCT(CONCAT_WS('-', iso_3166_1, iso_3166_2, onu)) FROM `pv_accommodations`").map{|c| c[0]}.sort
  end

  def has_summer_holidays_page?(resort)
    resort.ski? && !resort.summer_only? && resort.has_visible_page?('summer-holidays')
  end

  def resort_link_with_count(path, title, link_text, count)
    return if count == 0

    opts = current_page?(path) ? {class: 'active'} : {}

    content_tag(:li, link_to(h(link_text) + content_tag(:span, "(#{count})"), path, title: title), opts)
  end
end
