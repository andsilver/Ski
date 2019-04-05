require "rails_helper"

RSpec.describe LateAvailabilityController, type: :controller do
  let(:website) { double(Website).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
  end

  describe "GET index" do
    it "finds 8 featured late availability properties" do
      finder = double(LateAvailability::Finder)
      expect(LateAvailability::Finder).to receive(:new).and_return(finder)
      expect(finder).to receive(:find_featured).with(limit: 8)
      get "index"
    end
  end
end
