class PropertyImportController < ApplicationController
  before_action :user_required, except: [:import_documentation]

  def new_import
  end

  def import
    cleanup_import("No file uploaded") && return if params[:file].nil?

    @file = params[:file]
    @path = "#{Rails.root}/public/up/users/#{@current_user.id}/properties_upload"
    FileUtils.makedirs(@path)
    zip_filename = "#{@path}/properties.zip"
    File.open(zip_filename, "wb") { |file| file.write(@file.read) }
    zip_result = system("unzip -jo #{zip_filename} -d #{@path}")
    cleanup_import("Error extracting ZIP file") && return unless zip_result

    csv_filename = "#{@path}/properties.csv"
    cleanup_import("Could not find properties.csv in ZIP file") && return unless File.exist?(csv_filename)

    require "csv"

    @total_read = @newly_imported = @updated = @failed = 0
    flash[:errors] = []

    csv = File.open(csv_filename, "rb")
    @parsed_file = defined?(CSV::Reader) ? CSV::Reader.parse(csv) : CSV.parse(csv)

    @parsed_file.each do |row|
      process_row(row)
    rescue RuntimeError => e
      cleanup_import(e) && (return)
    end

    cleanup_import "Total read: #{@total_read}, Newly imported: #{@newly_imported}, Updated: #{@updated}, Failed: #{@failed}"
  end

  def pericles_import
    default_resort = Resort.find_by(id: params[:resort_id])
    unless default_resort
      redirect_to property_importer_new_pericles_import_path, notice: "Please select a default resort."
      return
    end

    @path = "#{Rails.root}/public/up/users/#{@current_user.id}/properties_upload"
    xml_filename = "#{@path}/mbiarve.XML"

    require "xmlsimple"

    @total_read = @newly_imported = @updated = @failed = 0
    flash[:errors] = []

    xml_file = File.open(xml_filename, "rb")
    xml = XmlSimple.xml_in(xml_file)
    xml_file.close
    xml["BIEN"].each do |property_xml|
      @total_read += 1
      begin
        p_p = PericlesProperty.new(property_xml)
      rescue RuntimeError => e
        @failed += 1
        flash[:errors] << "Property with NO_ASP=#{property_xml["NO_ASP"][0]} failed: #{e}"
        next
      end
      puts p_p
      puts "-------"
      property = Property.find_by(user_id: @current_user.id, pericles_id: p_p.pericles_id)
      property ||= new_import_property

      new_record = property.new_record?
      p_p.prepare_property(property)
      property.tidy_name_and_strapline
      property.resort_id = default_resort.id

      p(property)
      puts "-------"

      if property.save
        GC.start if property.id % 50 == 0
        if new_record
          @newly_imported += 1
        else
          @updated += 1
        end
      else
        if @failed < 5
          error = "Problem with property in with NO_ASP=#{p_p.pericles_id}:"
          property.errors.full_messages.each do |msg|
            error += " [#{msg}]"
          end
          flash[:errors] << error
        else
          flash[:errors] << "Also NO_ASP=#{p_p.pericles_id}"
        end
        @failed += 1
      end

      process_imported_pericles_images(p_p, property) if new_record
    end

    redirect_to property_importer_new_pericles_import_path,
      notice: "Total read: #{@total_read}, Newly imported: #{@newly_imported}, Updated: #{@updated}, Failed: #{@failed}"
  end

  protected

  def process_row(row)
    if @mapping.nil?
      @mapping = csv_mapping_from_header(row)
      %w[resort_id name address description for_sale].each do |required|
        raise "CSV missing required field: #{required}" if @mapping[required].nil?
      end
      return
    end

    @total_read += 1

    property = Property.find_by(user_id: @current_user.id, name: row[@mapping["name"]])
    property ||= new_import_property

    new_record = property.new_record?

    Property.importable_attributes.each do |attribute|
      unless @mapping[attribute].nil? || attribute == "images"
        unless row[@mapping[attribute]].blank?
          property[attribute] = row[@mapping[attribute]]
          puts "#{attribute} = #{property[attribute]}"
        end
      end
    end

    property.tidy_name_and_strapline

    if property.save
      GC.start if property.id % 50 == 0
      if new_record
        @newly_imported += 1
      else
        @updated += 1
      end
    else
      if @failed < 5
        error = "Problem with property in row #{@total_read + 1}:"
        property.errors.full_messages.each do |msg|
          error += " [#{msg}]"
        end
        flash[:errors] << error
      else
        flash[:errors] << "Also row #{@total_read + 1}"
      end
      @failed += 1
    end

    if new_record && @mapping["images"]
      process_imported_images(property, row[@mapping["images"]])
    end
  end

  def new_import_property
    property = Property.new
    property.user_id = @current_user.id
    property.distance_from_town_centre_m = 0
    property
  end

  def process_imported_images(property, images)
    return if images.nil?

    image_filenames = images.split("|")
    first = true
    image_filenames.each do |filename|
      filename.strip!
      puts "processing image: #{filename}"

      image = nil
      if filename[0..3] == "http"
        image = Image.new(source_url: filename)
      else
        filename = File.basename(filename)
        path = "#{@path}/#{filename}"
        if File.exist? path
          file = File.open(path)
          image = Image.new
          image.image = file
          file.close
        end
      end

      unless image.nil?
        image.user_id = property.user_id
        image.property_id = property.id
        image.save
        if first
          property.image_id = image.id
          property.save
          first = false
        end
      end
    end
  end

  def process_imported_pericles_images(pericles_property, property)
    first = true
    ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o"].each do |letter|
      filename = "#{pericles_property.company_code}-#{pericles_property.site_code}-#{pericles_property.pericles_id}-#{letter}.jpg"
      puts "processing image: #{filename}"
      path = "#{@path}/#{filename}"
      if File.exist? path
        file = File.open(path)
        image = Image.new
        image.image = file
        image.user_id = property.user_id
        image.property_id = property.id
        image.save
        if first
          property.image_id = image.id
          property.save
          first = false
        end
        file.close
      end
    end
  end

  def cleanup_import notice
    FileUtils.rm_rf(@path) unless @path.nil?
    redirect_to property_importer_new_import_path, notice: notice
  end

  def csv_mapping_from_header(row)
    mapping = {}
    row.each_with_index do |header, pos|
      puts "looking at: #{header}"
      mapping[header] = pos if Property.importable_attributes.include? header
    end
    puts mapping
    mapping
  end
end
