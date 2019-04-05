require "rails_helper"

RSpec.describe HolidayTypesController, type: :controller do
  let(:website) { double(Website).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
  end

  describe "GET show" do
    it "finds holiday type by its slug" do
      expect(HolidayType).to receive(:find_by).with(slug: "slug")
      get "show", params: {"id" => "slug"}
    end

    context "when holiday type not found" do
      before { allow(HolidayType).to receive(:find_by).and_return(nil) }

      it "renders 404" do
        get "show", params: {"id" => "slug"}
        expect(response.status).to eq 404
      end
    end
  end
end
