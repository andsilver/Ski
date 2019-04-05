module Interhome
  class SoapRequest
    attr_reader :request_object

    def initialize(request_object, url)
      @request_object = request_object

      @curl = Curl::Easy.perform(url) { |curl|
        curl.headers["SOAPAction"] = "http://www.interhome.com/webservice/#{request_object.action}"
        curl.headers["Content-Type"] = "text/xml; charset = utf-8"
        curl.headers["Connection"] = "close"
        curl.encoding = "UTF-8"
        curl.ssl_verify_peer = false
        curl.verbose = true
        curl.post_body = request_object.xml
      }
    end

    def xml_response
      @curl.body_str
    end
  end
end
