require "rails_helper"

RSpec.describe RolesController, type: :controller do
  let(:website) { double(Website).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
  end

  describe "GET sales_pitch" do
    let(:role) { mock_model(Role).as_null_object }

    it "finds the role by its SEO param" do
      expect(Role).to receive(:find_by).with(name: "property developer")
      get "sales_pitch", params: {role: "property-developer"}
    end

    context "when the role exists" do
      pending
    end

    context "when the role does not exist" do
      it "renders not found" do
        allow(Role).to receive(:find_by).and_return(nil)
        put "sales_pitch", params: {role: "property-developer"}
        expect(response.status).to eql 404
      end
    end
  end
end
