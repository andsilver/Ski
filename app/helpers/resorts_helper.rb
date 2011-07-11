module ResortsHelper
  THUMBNAIL_SIZE = 160
  PHOTO_SIZE = 500

  def gallery_thumbnail(resort, filename)
    gallery_image(resort, filename, THUMBNAIL_SIZE)
  end

  def gallery_photo(resort, filename)
    gallery_image(resort, filename, PHOTO_SIZE)
  end

  def gallery_image(resort, filename, size)
    thumbnails_url = "/resorts/#{PermalinkFu.escape(@resort.name)}/gallery/#{size}"
    url = "#{thumbnails_url}/#{filename}"
    original_path = "#{Rails.root.to_s}/public/resorts/#{PermalinkFu.escape(@resort.name)}/gallery/#{filename}"
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
end
