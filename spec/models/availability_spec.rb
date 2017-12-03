require 'rails_helper'

RSpec.describe Availability, type: :model do
  describe 'validations' do
    it do
      should validate_inclusion_of(:availability)
        .in_array(Availability::AVAILABILITIES)
    end
    it { should validate_presence_of(:start_date) }
  end
end
