class Image < ActiveRecord::Base
  IMAGE_STORAGE_PATH = "#{Rails.root.to_s}/public/up/images"
  IMAGE_STORAGE_URL = "/up/images"
  IMAGE_MISSING = "image-missing.png"

  before_save   :determine_filename
  after_save    :write_file
  after_destroy :delete_files

  belongs_to :property
  belongs_to :user

  attr_reader :was_sized

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
      remote_image? ? source_url : url_for_filename(filename)
    else
      sized_url(size, :longest_side)
    end
  end

  def height
    ImageScience.with_image(original_path) {|i| return i.height}
  end

  def width
    ImageScience.with_image(original_path) {|i| return i.width}
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

  def size_original!(size, method)
    sized_url(size, method, force_local: true)

    if was_sized
      FileUtils.rm(original_path) if File.exist?(original_path)
      FileUtils.cp(sized_path(size, method), original_path)
    end
  end

  def sized_url(size, method, options = {})
    options.reverse_merge!(force_local: false)
    @was_sized = false

    unless [:cropped, :height, :width, :longest_side, :maxpect, :square].include?(method)
      raise ArgumentError.new("method must be :cropped, :longest_side, :maxpect, :square, :height or :width")
    end

    return source_url if remote_image?

    f = sized_filename(size, method)
    path = sized_path(size, method)
    s3_path = path + '.s3uploaded'

    return s3_url_for_filename(f) if Rails.env == 'production' && File.exist?(s3_path)

    # create a new image of the required size if it doesn't exist
    unless FileTest.exist?(path)
      begin
        ImageScience.with_image(original_path) do |img|
          send("size_#{method}", img, size, path)
        end
      rescue
        return IMAGE_MISSING
      end
    end

    return IMAGE_MISSING unless File.exist?(path)

    @was_sized = true

    upload_to_s3 = (Rails.env == 'production' && !options[:force_local])

    if upload_to_s3
      unless File.exist?(s3_path)
        s3_upload(path)
        FileUtils.touch(s3_path)
      end

      FileUtils.rm(path) if File.exist?(path)

      return s3_url_for_filename(f)
    else
      return url_for_filename(f)
    end
  end

  def sized_filename(size, method)
    method.to_s + '_' + size.to_s.gsub(', ', 'x').gsub('[', '').gsub(']', '') + '.' + extension
  end

  def sized_path(size, method)
    "#{directory_path}/#{sized_filename(size, method)}"
  end

  def size_cropped(img, size, path)
    width = size[0]
    height = size[1]

    src_ar = img.width.to_f / img.height.to_f
    thumb_ar = width.to_f / height.to_f

    if(src_ar > thumb_ar)
      new_width = (img.height.to_f * thumb_ar).to_i
      shave = ((img.width - new_width).to_f / 2.0).to_i
      img.with_crop(shave, 0, img.width - shave, img.height) do |cropped|
        size_maxpect(cropped, size, path)
      end
    else
      new_height = (img.width.to_f / thumb_ar).to_i
      shave = ((img.height - new_height).to_f / 2.0).to_i
      img.with_crop(0, shave, img.width, img.height - shave) do |cropped|
        size_maxpect(cropped, size, path)
      end
    end
  end

  def size_longest_side(img, size, path)
    img.thumbnail(size) { |thumb| thumb.save path }
  end

  def size_height(img, size, path)
    img.resize(img.width * size / img.height, size) do |thumb|
      thumb.save path
    end
  end

  def size_width(img, size, path)
    img.resize(size, img.height * size / img.width) do |thumb|
      thumb.save path
    end
  end

  def size_square(img, size, path)
    img.cropped_thumbnail(size) { |thumb| thumb.save path }
  end

  def size_maxpect(img, size, path)
    if size.kind_of? Array
      width = size[0]
      height = size[1]
    else
      width = height = size
    end

    src_ar = img.width.to_f / img.height.to_f
    thumb_ar = width.to_f / height.to_f
    tolerance = 0.1
    if(src_ar * (1+tolerance) < thumb_ar || src_ar / (1+tolerance) > thumb_ar)
      if(src_ar > thumb_ar)
        height = (width / src_ar).to_i
      else
        width = (height * src_ar).to_i
      end
    end
    img.resize(width, height) do |thumb|
      thumb.save(path)
    end
  end

  def remote_image?
    !(FileTest.exist?(original_path) || source_url.blank?)
  end

  def valid_image_file?
    return true if remote_image?
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
    return unless File.exist?(directory_path)

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
