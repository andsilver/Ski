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
    elsif !source_url.blank?
      self.filename = 'image.jpg'
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
      FileUtils.makedirs(directory_path)
      File.open(original_path, "wb") { |file| file.write(@file_data.read) }
    end
  end

  def url(size=nil)
    if size.nil?
      download_from_source_if_needed
      url_for_filename(filename)
    else
      sized_url(size, :longest_side)
    end
  end

  def url_for_filename(fn)
    "#{directory_url}/#{fn}"
  end

  def original_path
    "#{directory_path}/#{filename}"
  end

  def directory_path
    "#{IMAGE_STORAGE_PATH}/#{sub_path}"
  end

  def directory_url
    "#{IMAGE_STORAGE_URL}/#{sub_path}"
  end

  # creates a partitioned sub-path based on the ID like ff/1023
  def sub_path
    "#{"%02x" % (id.to_i % 256)}/#{id}"
  end

  def sized_url(size, method)
    if method != :longest_side && method != :height
      raise ArgumentError.new("method must be :longest_side or :height")
    end

    download_from_source_if_needed

    f = method.to_s + '_' + size.to_s + '.' + extension
    path = "#{directory_path}/#{f}"
    # create a new image of the required size if it doesn't exist
    unless FileTest.exists?(path)
      begin
        ImageScience.with_image(original_path) do |img|
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

  def download_from_source_if_needed
    download_from_source unless FileTest.exists?(original_path) or source_url.blank?
  end

  def download_from_source
    begin
      FileUtils.makedirs(directory_path)
    rescue
      return
    end

    require 'net/http'
    uri = URI.parse(source_url)
    Net::HTTP.start(uri.host, uri.port) do |http|
      resp = http.get(uri.path)
      open(original_path, "wb") do |file|
        file.write(resp.body)
      end
    end
  end

  # Deletes the file(s) by removing the whole directory.
  def delete_files
    FileUtils.rm_rf(directory_path) unless id.nil?
  end

  def uploaded_extension
    if @file_data.respond_to? 'original_filename'
      @file_data.original_filename.split(".").last.downcase
    else
      'jpg'
    end
  end

  def extension
    e = filename.split(".").last
    e = '' if e.nil?
    e
  end

  def dimensions
    ImageScience.with_image(original_path) do |img|
      [img.width, img.height]
    end
  end
end
