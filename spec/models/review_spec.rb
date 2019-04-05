# frozen_string_literal: true

require "rails_helper"

RSpec.describe Review, type: :model do
  describe "associations" do
    it { should belong_to(:property) }
  end

  describe "validations" do
    it { should validate_presence_of(:author_location) }
    it { should validate_presence_of(:author_name) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:title) }
  end
end
