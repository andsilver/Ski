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
    unless FileTest.exists?(path)
      begin
        ImageScience.with_image(original_path) do |img|
          img.thumbnail(size) do |thumb|
            thumb.save path
          end
        end
      rescue
        return ''
      end
    end
    url.gsub(' ', '%20')
  end

  def header_image_urls
    urls = []

    if @resort && @resort.image
      urls << @resort.image.url
    end

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

    if urls.empty? && @country
      if @country.image
        urls << @country.image.url
      end
      country_images(@country, 'headers')
      @images.each do |img|
        urls << "/countries/#{@country.name.parameterize}/headers/#{img}"
      end
    end

    if urls.empty?
      urls << '/images/chamonix.jpg'
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
end
