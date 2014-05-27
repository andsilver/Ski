module FlipKey
  class PropertyImporter < ::AccommodationImporter
    def model_class
      FlipKeyProperty
    end

    def user_email
      'flipkey@mychaletfinder.com'
    end
  end
end
