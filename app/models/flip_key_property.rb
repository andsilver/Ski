class FlipKeyProperty < ActiveRecord::Base
  has_one :property, dependent: :destroy

  def parsed_json
    @parsed_json ||= JSON.parse(json_data)
  end
end
