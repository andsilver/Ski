require 'rails_helper'

RSpec.describe Availability, type: :model do
  it { should validate_inclusion_of(:availability).in_array(Availability::AVAILABILITIES) }
end
