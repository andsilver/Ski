require "rails_helper"

RSpec.describe "Property sales", type: :request do
  before { FactoryBot.create(:website) }

  describe "GET /property_sales" do
    it "renders content from the CMS" do
      FactoryBot.create(
        :page,
        path: "/property_sales",
        content: '<h1 class="home">International Property Sales</h1>'
      )
      get "/property_sales"
      assert_select "h1.home", "International Property Sales"
    end
  end
end
