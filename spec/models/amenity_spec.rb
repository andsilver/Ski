# frozen_string_literal: true

require "rails_helper"

RSpec.describe Amenity, type: :model do
  describe "associations" do
    it { should have_and_belong_to_many(:properties) }
  end

  describe "validations" do
    subject { FactoryBot.build(:amenity) }
    it { should validate_uniqueness_of(:name) }
  end
end
