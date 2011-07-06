class Image < ActiveRecord::Base
  IMAGE_STORAGE_PATH = "#{Rails.root.to_s}/public/up/images"
  IMAGE_STORAGE_URL = "/up/images"
  IMAGE_MISSING = "image-missing.png"

  attr_protected :user_id

  before_save   :determine_filename
  after_save    :write_file
  after_destroy :delete_files

  belongs_to :property

  def image=(file_data)
    unless file_data.kind_of? String and file_data.empty?
      @file_data = file_data
    end
  end

  def determine_filename
    if @file_data
      self.filename = "image.#{uploaded_extension}"
    else
      raise "No file data."
    end
  end

  # write the @file_data data content to disk,
  # using the IMAGE_STORAGE_PATH constant.
  # saves the file with the filename of the model id
  # together with the file original extension
  def write_file
    if @file_data
      # remove any existing images (which may have different extensions)
      delete_files
      path = "#{IMAGE_STORAGE_PATH}/#{id}"
      FileUtils.makedirs(path)
      File.open(path + '/' + filename, "wb") { |file| file.write(@file_data.read) }
    end
  end

  def url(size=nil)
    if size.nil?
      url_for_filename(filename)
    else
      sized_url(size, :longest_side)
    end
  end

  def url_for_filename(fn)
    "#{IMAGE_STORAGE_URL}/#{id}/#{fn}"
  end

  def sized_url(size, method)
    if method != :longest_side && method != :height
      raise ArgumentError.new("method must be :longest_side or :height")
    end

    f = method.to_s + '_' + size.to_s + '.' + extension
    path = "#{IMAGE_STORAGE_PATH}/#{id}/#{f}"
    # create a new image of the required size if it doesn't exist
    unless FileTest.exists?(path)
      begin
        ImageScience.with_image("#{IMAGE_STORAGE_PATH}/#{id}/#{filename}") do |img|
          if(method == :longest_side)
            img.thumbnail(size) do |thumb|
              thumb.save path
            end
          elsif(method == :height)
            img.resize(img.width * size / img.height, size) do |thumb|
              thumb.save path
            end
          end
        end
      rescue
        return IMAGE_MISSING
      end
    end
    url_for_filename(f)
  end

  # deletes the file(s) by removing the whole dir
  def delete_files
    FileUtils.rm_rf("#{IMAGE_STORAGE_PATH}/#{id}") unless id.nil?
  end

  def uploaded_extension
    @file_data.original_filename.split(".").last.downcase
  end

  def extension
    e = filename.split(".").last
    e = '' if e.nil?
    e
  end

  def dimensions
    ImageScience.with_image("#{IMAGE_STORAGE_PATH}/#{id}/#{filename}") do |img|
      [img.width, img.height]
    end
  end
end
