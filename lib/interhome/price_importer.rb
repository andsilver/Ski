require "xmlsimple"

module Interhome
  class PriceImporter
    attr_accessor :sales_office, :days

    def initialize(sales_office, days)
      @sales_office, @days = sales_office, days
    end

    # Gets the zipped XML file from the Interhome FTP server and
    # decompresses it.
    def ftp_get
      FTP.get(xml_filename)
    end

    # Splits the large Interhome XML file into a number of smaller files and
    # returns an array of XML filenames. Set max_files to limit the number
    # of smaller files created (for example, when testing).
    def split_xml(max_files = 0)
      xs = XMLSplitter.new(root_element: "prices", child_element: "price", xml_filename: "interhome/#{xml_filename}", elements_per_file: 2000, max_files: max_files)
      xs.split
    end

    # Imports Interhome prices from an array of filenames of XML files.
    # All previously existing prices for the specified number of days are deleted.
    def import(filenames)
      InterhomePrice.where(days: @days).delete_all
      filenames.each {|f| import_file(f)}
    end

    protected

    def import_file(filename)
      xml_file = File.open(filename, "rb")
      xml = XmlSimple.xml_in(xml_file)
      xml_file.close

      xml["price"].each {|p| import_price(p)} if xml
    end

    def import_price(p)
      @price = InterhomePrice.new
      @price.days = @days
      @price.accommodation_code = p["code"][0]
      @price.start_date = p["startdate"][0]
      @price.end_date = p["enddate"][0]

      # Price without any special offers.
      @price.regular_price = p["regularprice"][0]

      # Rental price may be the same as the regular or special offer price.
      # It reflects the current price including any special offer.
      @price.rental_price = p["rentalprice"][0]

      @price.min_rental_price = p["minrentalprice"][0]
      @price.max_rental_price = p["maxrentalprice"][0]
      if p["specialoffer"]
        @price.special_offer_code = p["specialoffer"][0]["code"][0]
        @price.special_offer_price = p["specialoffer"][0]["specialofferprice"][0]
      end
      @price.save
    end

    def xml_filename
      if days == 7
        "price_#{@sales_office}_gbp.xml"
      else
        "price_#{@sales_office}_gbp_#{days}.xml"
      end
    end
  end
end
