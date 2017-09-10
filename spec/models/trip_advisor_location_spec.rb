require 'rails_helper'

RSpec.describe TripAdvisorLocation, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:location_type) }
  end

  describe 'associations' do
    it { should have_many(:trip_advisor_properties).dependent(:nullify) }
    it { should belong_to(:resort) }
  end

  describe 'acts_as_tree' do
    it { should respond_to(:parent) }
    it { should respond_to(:children) }
  end
end
