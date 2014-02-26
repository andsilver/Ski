module FlipKey
  class PropertyIndexParser
    # +index+ should respond to +#read+ with a string of HTML.
    def initialize(index)
      @index = index
    end

    # Parses the HTML and returns an array of property data filenames.
    def parse
      doc = Nokogiri::HTML.parse(@index.read)
      doc.css('a')
        .map    { |link| link['href'] }
        .select { |f| property_data_filename?(f) }
    end

    private

      def property_data_filename?(f)
        /\Aproperty_data_\d+\.xml\.gz\z/ =~ f
      end
  end
end
