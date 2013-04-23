class Image < ActiveRecord::Base
  IMAGE_STORAGE_PATH = "#{Rails.root.to_s}/public/up/images"
  IMAGE_STORAGE_URL = "/up/images"
  IMAGE_MISSING = "image-missing.png"

  before_save   :determine_filename
  after_save    :write_file
  after_destroy :delete_files

  belongs_to :property
  belongs_to :user

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
      raise "No file data." if new_record?
    end
  end

  def write_file
    if @file_data
      @file_data.rewind
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

  def s3_bucket_name
    "mcf-up-images-%x" % (id.to_i % 16)
  end

  def s3_url_for_filename(fn)
    "http://s3.amazonaws.com/#{s3_bucket_name}/#{s3_key(fn)}"
  end

  def s3_key(fn)
    "#{id}/#{fn}"
  end

  def s3_upload(path)
    fn = File.basename(path)
    s3 = AWS::S3.new
    bucket = s3.buckets[s3_bucket_name]
    obj = bucket.objects.create(
      s3_key(fn),
      Pathname.new(path),
      acl: :public_read,
      reduced_redundancy: true
    )
  end

  def sized_url(size, method)
    if method != :longest_side && method != :height
      raise ArgumentError.new("method must be :longest_side or :height")
    end

    download_from_source_if_needed

    f = method.to_s + '_' + size.to_s + '.' + extension
    path = "#{directory_path}/#{f}"
    s3_path = path + '.s3uploaded'

    return s3_url_for_filename(f) if Rails.env == 'production' && File.exists?(s3_path)

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

    return IMAGE_MISSING unless File.exists?(path)

    if Rails.env == 'production'
      unless File.exists?(s3_path)
        s3_upload(path)
        FileUtils.touch(s3_path)
      end

      FileUtils.rm(path) if File.exists?(path)

      return s3_url_for_filename(f)
    else
      return url_for_filename(f)
    end
  end

  def download_from_source_if_needed
    download_from_source if needs_downloading?
  end

  def needs_downloading?
    !(FileTest.exists?(original_path) || source_url.blank?)
  end

  def download_from_source
    return if Rails.env == 'development'
    begin
      FileUtils.makedirs(directory_path)
      require 'net/http'
      uri = URI.parse(source_url)
      Net::HTTP.start(uri.host, uri.port) do |http|
        to_get = uri.path
        to_get = "#{to_get}?" + uri.query unless uri.query.blank?
        resp = http.get(to_get)
        open(original_path, "wb") do |file|
          file.write(resp.body)
        end
      end
    rescue
      return
    end
  end

  def valid_image_file?
    return true if needs_downloading?
    return true unless extension == 'jpg'

    begin
      File.open(original_path, "rb") do |file|
        b1 = file.readbyte
        b2 = file.readbyte
        b3 = file.readbyte
        gif = b1 == 0x47 && b2 == 0x49 && b3 == 0x46
        jpg = b1 == 0xff && b2 == 0xd8
        png = b1 == 0x89 && b2 == 0x50 && b3 == 0x4e
        return gif || jpg || png
      end
    rescue
      false
    end
  end

  # Deletes the file(s) by removing the whole directory and
  # removing remote files from Amazon S3.
  def delete_files
    return if id.nil?
    return unless File.exists?(directory_path)

    FileUtils.rm_rf(directory_path)
    s3_delete_files
  end

  # Deletes resized versions hosted on Amazon S3.
  def s3_delete_files
    s3 = AWS::S3.new
    bucket = s3.buckets[s3_bucket_name]
    bucket.objects.with_prefix("#{id}/").each do |obj|
      obj.delete
    end
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
