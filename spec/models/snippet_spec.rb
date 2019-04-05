# frozen_string_literal: true

require "rails_helper"

RSpec.describe Snippet, type: :model do
  describe "validations" do
    subject { Snippet.new }
    it { should validate_inclusion_of(:locale).in_array(Snippet::LOCALES) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:locale) }
  end
end
