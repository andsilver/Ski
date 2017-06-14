require 'rails_helper'

RSpec.describe TripAdvisorProperty, type: :model do
  it { should belong_to :trip_advisor_location }
end
