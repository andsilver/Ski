# Base class for responses sent from Interhome web services back to this app
# Provides convenience methods to access the interesting parts of the XML response

module Interhome
  class Response
    attr_reader :soap_request, :xml

    def initialize(soap_request)
      @soap_request = soap_request
      self.xml = soap_request.xml_response

      use_fixture_xml if Rails.env.test?
    end

    # sets the XML content and also parses it
    def xml=(xml)
      @xml = xml
      require "xmlsimple"
      @data = XmlSimple.xml_in(xml)
    end

    def errors?
      result["Errors"][0]
    end

    def error_messages_detail
      error_messages["MessageDetail"][0]["Detail"][0]
    end

    def error_messages
      result["ErrorMessages"][0]
    end

    def ok?
      result["Ok"][0] == "true"
    end

    def message
      result["Message"][0]
    end

    def result
      raise "override #result"
    end

    def requested(key)
      @soap_request.request_object.details[key]
    end

    protected

    # override in subclass for testing
    def use_fixture_xml
    end
  end
end
