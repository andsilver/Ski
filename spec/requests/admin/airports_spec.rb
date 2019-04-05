require "rails_helper"

RSpec.describe "Airports admin", type: :request do
  before do
    FactoryBot.create(:website)
    allow_any_instance_of(ApplicationController)
      .to receive(:admin?)
      .and_return(true)
  end

  describe "GET /admin/airports" do
    it "lists airports" do
      airport = FactoryBot.create(:airport)
      get admin_airports_path
      assert_select "td", content: airport.code
    end
  end

  describe "GET /admin/airports/new" do
    it "shows a form" do
      get new_admin_airport_path
      assert_select "form[action='#{admin_airports_path}']"
    end
  end

  describe "POST /admin/airports" do
    context "with valid params" do
      let(:country) { FactoryBot.create(:country) }
      before do
        post(
          admin_airports_path,
          params: {
            airport: {
              code: "DSA",
              name: "Doncaster Sheffield Airport",
              country_id: country.id,
            },
          }
        )
      end

      it "creates a new airport" do
        airport = Airport.last
        expect(airport).to be
        expect(airport.code).to eq "DSA"
        expect(airport.name).to eq "Doncaster Sheffield Airport"
        expect(airport.country).to eq country
      end

      it "redirects to the airports index" do
        expect(response).to redirect_to(admin_airports_path)
      end

      it "sets a flash notice" do
        expect(flash[:notice]).to eq I18n.t("notices.created")
      end
    end

    context "with invalid params" do
      before do
        post(
          admin_airports_path,
          params: {
            airport: {
              code: "DSA",
              name: "Doncaster Sheffield Airport",
            },
          }
        )
      end

      it "shows the form again" do
        assert_select "form[action='#{admin_airports_path}']" do
          assert_select "input[name='airport[code]'][value='DSA']"
        end
      end
    end
  end

  describe "GET /admin/airports/:id/edit" do
    it "shows a form to edit the airport" do
      airport = FactoryBot.create(:airport)
      get edit_admin_airport_path(airport)
      assert_select "form[action='#{admin_airport_path(airport)}']"
    end
  end

  describe "PATCH /admin/airports/:id" do
    context "with valid params" do
      let(:airport) { FactoryBot.create(:airport) }
      let(:country) { FactoryBot.create(:country) }
      before do
        patch(
          admin_airport_path(airport),
          params: {
            airport: {
              code: "DSA",
              name: "Doncaster Sheffield Airport",
              country_id: country.id,
            },
          }
        )
      end

      it "updates the airport" do
        airport.reload
        expect(airport.code).to eq "DSA"
        expect(airport.name).to eq "Doncaster Sheffield Airport"
        expect(airport.country).to eq country
      end

      it "redirects to the airports index" do
        expect(response).to redirect_to(admin_airports_path)
      end

      it "sets a flash notice" do
        expect(flash[:notice]).to eq I18n.t("notices.saved")
      end
    end

    context "with invalid params" do
      let(:airport) { FactoryBot.create(:airport) }
      before do
        patch(
          admin_airport_path(airport),
          params: {airport: {code: "DSA", name: ""}}
        )
      end

      it "shows the form again" do
        assert_select "form[action='#{admin_airport_path(airport)}']" do
          assert_select "input[name='airport[code]'][value='DSA']"
        end
      end
    end
  end

  describe "DELETE /admin/airports/:id" do
    let(:airport) { FactoryBot.create(:airport) }
    before { delete admin_airport_path(airport) }

    it "deletes the airport" do
      expect(Airport.exists?(airport.id)).to be_falsey
    end

    it "redirects to the airports index" do
      expect(response).to redirect_to(admin_airports_path)
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to eq I18n.t("notices.deleted")
    end
  end
end
