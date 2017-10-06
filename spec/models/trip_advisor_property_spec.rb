# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TripAdvisorProperty, type: :model do
  describe 'associations' do
    it { should have_one(:property).dependent(:destroy) }
    it { should belong_to :trip_advisor_location }
    it { should delegate_method(:resort).to(:trip_advisor_location) }
    it { should belong_to(:currency) }
  end

  describe 'validations' do
    it do
      should validate_numericality_of(:review_average)
        .is_less_than_or_equal_to(5)
    end
    it { should validate_presence_of :currency }
  end
end
