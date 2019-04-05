require "rails_helper"

RSpec.describe TrackedAction, type: :model do
  describe "associations" do
    it { should belong_to(:trackable) }
  end
end
