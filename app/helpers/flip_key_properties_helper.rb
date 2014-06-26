module FlipKeyPropertiesHelper
  def flip_key_property_description(json)
    raw json['property_descriptions'][0]['property_description'][0]['description'][0].gsub("\n", '<br>')
  end
end
