module FlipKey
  class LocationIndexParser < IndexParser
    private

      def data_filename?(f)
        /\A\d+[a-z_]+\.xml\.gz\z/ =~ f
      end
  end
end
