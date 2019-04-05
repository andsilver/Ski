require "xmlsimple"

# A base class for importing accommodation from external providers.
# XML is assumed to be the format of the accommodation feed.
#
# To import a series of XML files:
#
#   AccommodationImporter.new.import([
#     'feed-provider/accommodation-0.xml',
#     'feed-provider/accommodation-1.xml'
#   ])
#
# Call #cleanup to remove accommodations that existed before the import but
# which weren't included in the filenames provided to #import:
#
#  importer = AccommodationImporter.new
#  importer.import(['feed-provider/accommodation-0.xml']).cleanup
class AccommodationImporter
  attr_accessor :import_start_time

  # The +User+ to which imported properties will belong.
  attr_accessor :user

  # Subclasses should implement the following methods:
  # * accommodation
  # * import_accommodation
  # * model_class
  # * user_email

  # Non-destructive import.
  # Updates existing accommodations and imports new accommodations
  # from the XML filenames provided in +filenames+.
  # Returns self.
  def import(filenames)
    setup
    filenames.each {|f| import_file(f)}
    self
  end

  def setup
    @user = User.find_by(email: user_email)
    raise "A user with email #{user_email} is required" unless @user

    @euro = Currency.euro
    raise "A currency with code EUR is required" unless @euro

    @import_start_time = Time.now
  end

  # Remove old accommodations by checking their updated_at timestamps.
  def cleanup
    delete_old_adverts
    destroy_all
  end

  # Imports a single XML file. Property geocoding is suspended for the
  # duration of the file's import.
  def import_file(filename)
    xml_file = File.open(filename, "rb")
    begin
      xml = XmlSimple.xml_in(xml_file)
    ensure
      xml_file.close
    end

    if xml
      Property.stop_geocoding
      a = accommodations(xml)
      if a
        a.each {|a| import_accommodation(a)}
      else
        Rails.logger.warn "AccommodationImporter::#import_filename: Nil accommodations in #{filename}"
      end
      Property.resume_geocoding
    else
      Rails.logger.warn "AccommodationImporter::#import_filename: Could not parse XML file #{filename}"
    end
  end

  def create_advert(property)
    LongTermAdvert.new(property).create
  end

  def delete_old_adverts
    Advert
      .where(["user_id = ? AND updated_at < ?", @user.id, @import_start_time])
      .delete_all
  end

  def destroy_all
    model_class.where(["updated_at < ?", @import_start_time]).destroy_all
  end

  def accommodations(xml)
    raise "Subclass should return an array of all accommodation XML"
  end

  def import_accommodation(a)
    raise "Subclass should import the data"
  end

  # Prepares a property by finding an existing +Property+ or initializing a
  # new one associated with the given accommodation key => id.
  #
  # See +PreparedProperty+ for more details.
  #
  # Example:
  #     p = prepare_property(my_accommodation_id: my_accommodation.id)
  #     ...
  #     create_advert(p)
  def prepare_property(accommodation_key_id)
    PreparedProperty.new(accommodation_key_id, @user).property
  end

  def model_class
    raise "Subclass should return an ActiveRecord model subclass"
  end

  def user_email
    raise "Subclass should return an email address for a user that will own the imported data"
  end
end
