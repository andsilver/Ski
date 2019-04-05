require "xmlsimple"

module Interhome
  class DescriptionImporter
    attr_reader :class_name

    def initialize(class_name)
      raise "invalid class name" if class_name != "InterhomeInsideDescription" && class_name != "InterhomeOutsideDescription"
      @class_name = class_name
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
      xs = XMLSplitter.new(root_element: "descriptions", child_element: "description", xml_filename: "interhome/" + xml_filename, elements_per_file: 1000, max_files: max_files)
      xs.split
    end

    # Imports Interhome inside descriptions from an array of filenames of XML files.
    # All previously existing inside descriptions are deleted.
    def import(filenames)
      Kernel.const_get(@class_name).delete_all
      filenames.each {|f| import_file(f)}
    end

    protected

    def import_file(filename)
      xml_file = File.open(filename, "rb")
      xml = XmlSimple.xml_in(xml_file)
      xml_file.close

      xml["description"].each {|d| import_description(d)} if xml
    end

    def import_description(d)
      @description = Kernel.const_get(@class_name).new
      @description.accommodation_code = d["code"][0]
      @description.description = d["text"][0]
      @description.save
    end

    def xml_filename
      if @class_name == "InterhomeInsideDescription"
        "insidedescription_en.xml"
      else
        "outsidedescription_en.xml"
      end
    end
  end
end
