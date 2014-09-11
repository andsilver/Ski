require 'rails_helper'

describe FlipKeyPropertiesHelper do
  describe '#flip_key_property_description' do
    it 'replaces both \n and \n\n with <br><br>' do
      input = "One\nTwo\n\nThree"
      expected = 'One<br><br>Two<br><br>Three'
      expect(flip_key_property_description(json_description(input))).to eq expected
    end
  end
  
  # Place description into the expected parsed JSON.
  def json_description(desc)
    {'property_descriptions' => [{'property_description' => [{'description' => [desc]}]}]}
  end
end
