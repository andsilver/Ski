module FlipKey
  class IndexParser
    # +index+ should respond to +#read+ with a string of HTML.
    def initialize(index)
      @index = index
    end

    # Parses the HTML and returns an array of data filenames.
    def parse
      doc = Nokogiri::HTML.parse(@index.read)
      doc.css('a')
        .map    { |link| link['href'] }
        .select { |f| data_filename?(f) }
    end

    private

      def data_filename?(f)
        raise 'Implementation required from subclass'
      end
  end
end
