module ResortsHelper
  THUMBNAIL_SIZE = 160
  PHOTO_SIZE = 500
  PISTE_MAP_SIZE = 821
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
    thumbnails_url = "/resorts/#{PermalinkFu.escape(@resort.name)}/#{sub_dir}/#{size}"
    url = "#{thumbnails_url}/#{filename}"
    original_path = "#{Rails.root.to_s}/public/resorts/#{PermalinkFu.escape(@resort.name)}/#{sub_dir}/#{filename}"
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
    url
  end

  def header_image_urls
    urls = []

    if @resort && @resort.image
      urls << @resort.image.url
    end

    if @resort
      resort_images(@resort, 'headers')
      @images.each do |img|
        urls << "/resorts/#{PermalinkFu.escape(@resort.name)}/headers/#{img}"
      end
    end

    if urls.empty? && @country && @country.image
      urls << @country.image.url
    end

    if urls.empty?
      urls << '/images/chamonix.jpg'
    end

    urls
  end

  def resort_images(resort, sub_dir)
    dir = "#{RESORTS_DIRECTORY}#{PermalinkFu.escape(resort.name)}/#{sub_dir}"
    begin
      @images = Dir.entries(dir).select {|e| e[0..0] != "." && e.include?(".")}
    rescue
      @images = []
    end
  end
end
