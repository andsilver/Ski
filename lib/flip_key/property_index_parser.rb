module FlipKey
  class PropertyIndexParser < IndexParser
    private

      def data_filename?(f)
        /\Aproperty_data_\d+\.xml\.gz\z/ =~ f
      end
  end
end
