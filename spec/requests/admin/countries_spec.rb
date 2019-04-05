require "rails_helper"

RSpec.describe "Countries admin", type: :request do
  before do
    FactoryBot.create(:website)
    allow_any_instance_of(ApplicationController)
      .to receive(:admin?)
      .and_return(true)
  end

  describe "GET /admin/countries" do
    it "lists all countries" do
      FactoryBot.create(:country, name: "France")

      get admin_countries_path

      assert_select "td", text: "France"
    end
  end

  describe "GET /admin/countries/new" do
    it "renders a new country form" do
      get new_admin_country_path

      assert_select "form[action='#{admin_countries_path}']"
    end
  end

  describe "DELETE /admin/countries/:id" do
    let(:country) { FactoryBot.create(:country) }

    it "deletes a country" do
      delete admin_country_path(country)
      expect(Country.exists?(country.id)).to be_falsy
    end

    it "redirects to countries admin page" do
      delete admin_country_path(country)
      expect(response).to redirect_to admin_countries_path
    end
  end
end
