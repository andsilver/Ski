module ResortsHelper
  THUMBNAIL_SIZE = 160
  PHOTO_SIZE = 500
  PISTE_MAP_SIZE = 821
  COUNTRIES_DIRECTORY = "#{Rails.root}/public/countries/"
  REGIONS_DIRECTORY = "#{Rails.root}/public/regions/"
  RESORTS_DIRECTORY = "#{Rails.root}/public/resorts/"

  def gallery_thumbnail(resort, filename)
    resort_image(resort, filename, THUMBNAIL_SIZE, "gallery")
  end

  def gallery_photo(resort, filename)
    resort_image(resort, filename, PHOTO_SIZE, "gallery")
  end

  def piste_map(resort, filename)
    resort_image(resort, filename, PISTE_MAP_SIZE, "piste-maps")
  end

  def resort_image(resort, filename, size, sub_dir)
    thumbnails_url = "/resorts/#{@resort.name.parameterize}/#{sub_dir}/#{size}"
    url = "#{thumbnails_url}/#{filename}"
    original_path = "#{Rails.root}/public/resorts/#{@resort.name.parameterize}/#{sub_dir}/#{filename}"
    path = "#{Rails.root}/public/#{url}"
    thumbnails_path = "#{Rails.root}/public/#{thumbnails_url}"

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
        return ""
      end
    end
    url.gsub(" ", "%20")
  end

  # Returns header image URLs for the current page.
  def header_image_urls
    urls = []

    return urls if @no_header

    [
      :resort_header_urls,
      :page_header_urls,
      :region_header_urls,
      :country_header_urls,
    ].each do |source|
      if urls.empty?
        urls = send(source) || []
      end
    end

    urls.map! {|u| u.gsub(" ", "%20")}
    urls
  end

  def resort_header_urls
    if @resort
      sub_dir = header_image_sub_directory
      resort_images(@resort, sub_dir)
        .map {|img| "/resorts/#{@resort.name.parameterize}/#{sub_dir}/#{img}"}
    end
  end

  def page_header_urls
    if controller.controller_name == "pages" && controller.action_name == "show"
      slug = params[:id]
      images_in_directory("#{Rails.root}/public/pages/#{slug}/headers")
        .map {|img| "/pages/#{slug}/headers/#{img}"}
    end
  end

  # Returns an array of URLs for header images for use in region pages. Only
  # the how-to-get-there page uses header images at this time as other region
  # pages use manually entered HTML and images.
  def region_header_urls
    if @region && controller.action_name == "how_to_get_there"
      region_images(@region)
        .map {|img| "/regions/#{@region.name.parameterize}/headers/#{img}"}
    end
  end

  def country_header_urls
    if @country
      urls = []
      if @country.image
        urls << @country.image.url
      end
      country_images(@country, "headers")
      @images.each do |img|
        urls << "/countries/#{@country.name.parameterize}/headers/#{img}"
      end
      urls
    end
  end

  # Returns a sub-directory containing a resort's header images based on the
  # resort page being shown.
  def header_image_sub_directory
    dirs = Hash.new("headers")
    dirs["ski_and_guiding_schools"] = "ski-school-headers"
    dirs["summer_holidays"] = "summer-headers"
    dirs[controller.action_name]
  end

  def region_images(region)
    dir = "#{REGIONS_DIRECTORY}#{region.name.parameterize}/headers"
    images_in_directory(dir)
  end

  def resort_images(resort, sub_dir)
    dir = "#{RESORTS_DIRECTORY}#{resort.name.parameterize}/#{sub_dir}"
    images_in_directory(dir)
  end

  def country_images(country, sub_dir)
    dir = "#{COUNTRIES_DIRECTORY}#{country.name.parameterize}/#{sub_dir}"
    @images = images_in_directory(dir)
  end

  def images_in_directory(dir)
    Dir.entries(dir).select {|e| e[0..0] != "." && e.include?(".")}.sort!
  rescue Errno::ENOENT
    []
  end

  def has_summer_holidays_page?(resort)
    resort.ski? && !resort.summer_only? && resort.has_visible_page?("summer-holidays")
  end

  # Returns HTML for a link to +path+ with +count+ in parentheses after the
  # +link_text+.
  #
  # The link has a class of active if +path+ is the current page.
  #
  # If +count+ is 0 then +nil+ is returned.
  def link_with_count(path, title, link_text, count)
    return if count == 0

    opts = current_page?(path) ? {class: "active"} : {}

    content_tag(:li, link_to(h(link_text) + content_tag(:span, "(#{count})"), path, title: title), opts)
  end
end
