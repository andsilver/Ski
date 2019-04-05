require "rails_helper"

RSpec.describe PropertiesController, type: :controller do
  let(:property) { FactoryBot.create(:property) }
  let(:website) { double(Website).as_null_object }
  let(:non_admin_role) { Role.new(admin: false) }

  render_views

  before do
    allow(Website).to receive(:first).and_return(website)
    allow(non_admin_role).to receive(:admin?).and_return(false)
  end

  describe "GET index" do
    context "when not signed in as admin" do
      it "redirects to the sign in page" do
        allow(controller).to receive(:signed_in?).and_return(true)
        allow(controller).to receive(:admin?).and_return(false)
        get :index
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  shared_examples "a protector of hidden resorts" do |method, action|
    let(:resort) { FactoryBot.create(:resort, visible: false) }

    context "with search results" do
      before { allow(controller).to receive(:search_status).and_return 200 }

      it "404s hidden resorts" do
        send(method, action, params: {resort_slug: resort.slug})
        expect(response.status).to eq 404
      end

      it "shows hidden resorts to admin" do
        allow(controller).to receive(:admin?).and_return(true)
        send(method, action, params: {resort_slug: resort.slug})
        expect(response.status).to eq 200
      end
    end

    context "with no search results" do
      before { allow(controller).to receive(:search_status).and_return 404 }

      it "404s even for admin" do
        allow(controller).to receive(:admin?).and_return(true)
        send(method, action, params: {resort_slug: resort.slug})
        expect(response.status).to eq 404
      end
    end
  end

  shared_examples "a country scoped search" do |method, action|
    let(:country) { FactoryBot.create(:country) }

    it "searches within a country" do
      pending
      send(method, action, params: {country_id: country.id})
      expect(assigns(:conditions).first).to include("country_id = ?")
    end
  end

  shared_examples "an availability filter" do |method, action|
    let(:property) { FactoryBot.create(:property, name: "Alpen Lounge") }

    before do
      Availability.create!(property: property, start_date: "2015-02-23", availability: Availability::AVAILABLE,   check_in: true,  check_out: false)
      Availability.create!(property: property, start_date: "2015-02-24", availability: Availability::UNAVAILABLE, check_in: false, check_out: true)
      Availability.create!(property: property, start_date: "2015-02-25", availability: Availability::AVAILABLE,   check_in: true,  check_out: true)

      Availability.create!(property: property, start_date: "2015-02-26", availability: Availability::AVAILABLE,   check_in: true,  check_out: false)
      Availability.create!(property: property, start_date: "2015-02-27", availability: Availability::AVAILABLE,   check_in: false, check_out: true)
      Availability.create!(property: property, start_date: "2015-02-28", availability: Availability::AVAILABLE,   check_in: true,  check_out: true)
    end

    it "assumes a one night stay when only start date is specified" do
      send(method, action, params: {start_date: "2015-02-23"})
      expect(response.body).to have_content "Alpen Lounge"
    end

    it "does not allow check-in on no check-in days" do
      send(method, action, params: {start_date: "2015-02-24"})
      expect(response.body).not_to have_content "Alpen Lounge"
    end

    it "disallows a two night stay when day in the middle is unavailable" do
      send(method, action, params: {start_date: "2015-02-23", end_date: "2015-02-25"})
      expect(response.body).not_to have_content "Alpen Lounge"
    end

    it "disallows a three night stay when one day in the middle is available " \
    "but another is not" do
      Availability.create!(
        property: property,
        start_date: "2018-01-01", availability: Availability::AVAILABLE,
        check_in: true, check_out: false
      )
      Availability.create!(
        property: property,
        start_date: "2018-01-02", availability: Availability::AVAILABLE,
        check_in: true, check_out: true
      )
      Availability.create!(
        property: property,
        start_date: "2018-01-03", availability: Availability::UNAVAILABLE,
        check_in: false, check_out: true
      )
      Availability.create!(
        property: property,
        start_date: "2018-01-04", availability: Availability::AVAILABLE,
        check_in: true, check_out: true
      )

      send(method, action, params: {start_date: "2018-01-01", end_date: "2018-01-04"})

      expect(response.body).not_to have_content "Alpen Lounge"
    end

    it "allows a two night stay when day in the middle is available" do
      send(method, action, params: {start_date: "2015-02-26", end_date: "2015-02-28"})
      expect(response.body).to have_content "Alpen Lounge"
    end
  end

  shared_examples_for "a region and resort setter" do |method, action|
    let(:resort_id) { nil }
    let(:resort_slug) { nil }
    let(:region_slug) { nil }

    before do
      send(
        method,
        action,
        params: {
          resort_id: resort_id,
          resort_slug: resort_slug,
          region_slug: region_slug,
        }
      )
    end

    context "given a resort slug that refers to a resort" do
      let(:resort) { FactoryBot.create(:resort) }
      let(:resort_slug) { resort.slug }

      it "sets the resort" do
        pending
        expect(assigns(:resort)).to eq(resort)
      end
    end
    context "given a resort slug that refers to a region" do
      let(:region) { FactoryBot.create(:region) }
      let(:resort_slug) { region.slug }

      it "sets the region" do
        pending
        expect(assigns(:region)).to eq(region)
      end
    end

    context "given a region slug" do
      let(:region) { FactoryBot.create(:region) }
      let(:region_slug) { region.slug }

      it "sets the region" do
        pending
        expect(assigns(:region)).to eq(region)
      end
    end
  end

  describe "GET quick_search" do
    it_behaves_like "a protector of hidden resorts", :get, :quick_search
    it_behaves_like "a country scoped search", :get, :quick_search
    it_behaves_like "an availability filter", :get, :quick_search
    it_behaves_like "a region and resort setter", :get, :quick_search
  end

  shared_examples_for "it requires a resort or region" do |method, action, listing_type|
    it "shows with a resort" do
      resort = FactoryBot.create(:resort)
      FactoryBot.create(:property, resort: resort, listing_type: listing_type)
      send(method, action, params: {resort_slug: resort.slug})
      expect(response.status).to eq 200
    end

    it "shows with a region" do
      region = FactoryBot.create(:region)
      resort = FactoryBot.create(:resort, region: region)
      FactoryBot.create(:property, resort: resort, listing_type: listing_type)
      send(method, action, params: {resort_slug: region.slug})
      expect(response.status).to eq 200
    end

    it "404s with neither a resort nor region" do
      FactoryBot.create(:property, listing_type: listing_type)
      send(method, action, params: {resort_slug: "nonexistent"})
      expect(response.status).to eq 404
    end
  end

  describe "GET browse_for_rent" do
    it_behaves_like "a protector of hidden resorts", :get, :browse_for_rent
    it_behaves_like "it requires a resort or region", :get, :browse_for_rent, Property::LISTING_TYPE_FOR_RENT
    it_behaves_like "a region and resort setter", :get, :browse_for_rent
  end

  describe "GET browse_for_sale" do
    it_behaves_like "a protector of hidden resorts", :get, :browse_for_sale
    it_behaves_like "it requires a resort or region", :get, :browse_for_sale, Property::LISTING_TYPE_FOR_SALE
    it_behaves_like "a region and resort setter", :get, :browse_for_sale
  end

  describe "GET new_developments" do
    let(:properties) { double(ActiveRecord::Relation).as_null_object }
    let!(:resort) { FactoryBot.create(:resort) }

    before do
      # FIXME
      # rel = double(Property::ActiveRecord_Relation)
      #  allow(Property).to receive(:where).and_return(rel)
      # allow(rel).to receive(:order).and_return(properties)
    end

    it_behaves_like "a protector of hidden resorts", :get, :new_developments
    it_behaves_like "a region and resort setter", :get, :new_developments

    it "finds a resort by its slug" do
      expect(Resort).to receive(:find_by).with(slug: resort.slug).and_call_original
      get :new_developments, params: {resort_slug: resort.slug}
    end

    it "finds paginated properties" do
      pending
      expect(properties).to receive(:paginate)
      get :new_developments, params: {resort_slug: resort.slug}
    end

    it "finds new developments" do
      expect(Property).to receive(:where).with(["publicly_visible = 1 AND resort_id = ? AND new_development = 1", resort.id]).and_return(properties)
      get :new_developments, params: {resort_slug: resort.slug}
    end

    it "assigns @properties" do
      pending
      get :new_developments, params: {resort_slug: resort.slug}
      expect(assigns[:properties]).to equal(properties)
    end
  end

  describe "GET new" do
    let(:current_user) { double(User).as_null_object }

    before do
      allow(controller).to receive(:signed_in?).and_return(true)
      allow(controller).to receive(:current_user).and_return(current_user)
      allow(current_user).to receive(:role).and_return(non_admin_role)
    end

    context "with params[:listing_type] set" do
      it "sets property.listing_type to the given param" do
        pending
        get :new, params: {listing_type: "1"}
        expect(assigns(:property).listing_type).to eq 1
      end
    end

    context "with params[:listing_type] not set" do
      it "doesn't set property.listing_type" do
        expect_any_instance_of(Property).to_not receive(:listing_type=)
        get :new
      end
    end
  end

  describe "GET update_day_of_month_select" do
    context "when params[:year_month] is set" do
      it "sets @year to the first four digits of year_month" do
        pending
        get "update_day_of_month_select", year_month: "2012-13"
        expect(assigns(:year)).to eq(2012)
      end

      it "sets @month to the 6th and 7th digits of year_month" do
        pending
        get "update_day_of_month_select", year_month: "2012-13"
        expect(assigns(:month)).to eq(13)
      end
    end

    context "when params[:year_month] is missing" do
      it "sets @year to the current year" do
        pending
        get "update_day_of_month_select"
        expect(assigns(:year)).to eq(Time.now.year)
      end

      it "sets @month to the current month" do
        pending
        get "update_day_of_month_select"
        expect(assigns(:month)).to eq(Time.now.month)
      end
    end
  end

  describe "POST create" do
    let(:current_user) { FactoryBot.create(:user) }
    let(:role) { double(Role).as_null_object }
    let(:property_attributes) {
      {
        layout: "Showcase",
        name: "Property",
        address: "Address",
        resort_id: FactoryBot.create(:resort).id,
        currency_id: FactoryBot.create(:currency).id,
      }
    }
    let(:create_params) { {property: property_attributes} }

    before do
      allow(Advert).to receive(:create_for)
      allow(controller).to receive(:current_user).and_return(current_user)
      allow(current_user).to receive(:role).and_return(role)
    end

    context "with valid attributes" do
      it "creates a new property with supplied attributes" do
        post "create", params: create_params
        expect(Property.find_by(property_attributes)).to be
      end

      context "when submitting in square feet" do
        it "converts square feet to square metres" do
          post "create", params: {property: property_attributes.merge({floor_area_metres_2: "1000", plot_size_metres_2: "2000"}), floor_area_unit: "f", plot_area_unit: "f"}
          expect(Property.last.floor_area_metres_2).to eq 93
          expect(Property.last.plot_size_metres_2).to eq 186
        end
      end

      context "when advertising through windows" do
        pending
      end

      context "when not advertising through windows" do
        before do
          allow(current_user).to receive(:advertises_through_windows?).and_return(false)
        end

        it "creates a corresponding advert" do
          expect(Advert).to receive(:create_for)
          post "create", params: create_params
        end
      end

      it "redirects to image uploading form" do
        post "create", params: create_params
        expect(response).to redirect_to(new_image_path)
      end
    end
  end

  describe "GET contact" do
    let(:resort) { FactoryBot.create(:resort) }

    def perform
      get :contact, params: {id: "1"}
    end

    it "finds a property" do
      expect(Property).to receive(:find_by).with(id: "1")
      perform
    end

    it "assigns @resort from the property's resort" do
      pending
      allow(property).to receive(:resort).and_return(resort)
      allow(Property).to receive(:find_by).and_return(property)
      perform
      expect(assigns(:resort)).to eq resort
    end

    it "assigns a new @enquiry linked to the property" do
      pending
      allow(Property).to receive(:find_by).and_return(property)
      perform
      expect(assigns(:enquiry)).to be
      expect(assigns(:enquiry).property).to eq property
    end
  end

  describe "GET interhome_booking_form" do
    let!(:accommodation) { FactoryBot.create(:interhome_accommodation) }

    context "with vacancy information" do
      before do
        FactoryBot.create(:interhome_vacancy, interhome_accommodation_id: accommodation.id)
      end

      it "renders the default template" do
        pending
        get "interhome_booking_form", params: {id: accommodation.id}
        expect(response).to render_template "interhome_booking_form"
      end
    end

    context "when vacancy information missing" do
      it "renders the interhome_no_vacancy_info template" do
        pending
        get "interhome_booking_form", params: {id: accommodation.id}
        expect(response).to render_template "properties/interhome_no_vacancy_info"
      end
    end
  end

  def find_a_property_belonging_to_the_current_user
    expect(Property).to receive(:find_by).with(id: "1", user_id: anything)
  end

  def signed_in_user
    allow(controller).to receive(:signed_in?).and_return(true)
    allow(controller).to receive(:current_user).and_return(current_user)

    allow(current_user).to receive(:role).and_return(non_admin_role)
  end

  describe "GET edit" do
    let(:current_user) { double(User).as_null_object }
    let(:property) { double(Property).as_null_object }

    before do
      signed_in_user
    end

    it "finds a property belonging to the current user" do
      find_a_property_belonging_to_the_current_user
      get :edit, params: {id: "1"}
    end

    context "when a valid_property is found" do
      before do
        allow(Property).to receive(:find_by).and_return(property)
      end

      it "assigns @property" do
        pending
        get :edit, params: {id: "1"}
        expect(assigns[:property]).to equal(property)
      end
    end

    context "when a valid_property is not found" do
      before do
        allow(Property).to receive(:find_by).and_return(nil)
      end

      it "renders not found" do
        get :edit, params: {id: "1"}
        expect(response.status).to eql 404
      end
    end
  end

  describe "PUT update" do
    let(:current_user) { double(User).as_null_object }
    let(:image_id)     { nil }

    def put_update
      put "update", params: {id: "1", property: {title: "T", image_id: image_id}}
    end

    before do
      signed_in_user
    end

    it "finds a property belonging to the current user" do
      find_a_property_belonging_to_the_current_user
      put_update
    end

    context "when a valid property is found" do
      let(:property) { double(Property).as_null_object }

      before do
        allow(Property).to receive(:find_by).and_return(property)
      end

      context "when image_id is set" do
        let(:property_owner) { FactoryBot.create(:user) }
        let(:image)    { FactoryBot.create(:image, source_url: "#", user: image_owner) }
        let(:image_id) { image.id }
        before         { allow(property).to receive(:user).and_return(property_owner) }

        context "when image owned by property owner" do
          let(:image_owner) { property_owner }

          it "sets the property image" do
            expect(property).to receive(:image=).with(image)
            put_update
          end
        end

        context "when image not owned by property owner" do
          let(:image_owner) { FactoryBot.create(:user) }

          it "does not set the property image" do
            expect(property).not_to receive(:image=)
            put_update
          end
        end
      end

      context "when the property updates successfully" do
        before do
          allow(property).to receive(:update_attributes).and_return(true)
        end

        it "redirects to my adverts page" do
          allow(property).to receive(:for_sale?).and_return(false)
          put_update
          expect(response).to redirect_to(my_adverts_path)
        end

        it "sets a flash[:notice] message" do
          put_update
          expect(flash[:notice]).to eq("Your property advert details have been saved.")
        end
      end

      context "when the property fails to update" do
        before do
          allow(property).to receive(:update_attributes).and_return(false)
        end

        it "assigns @property" do
          pending
          put_update
          expect(assigns[:property]).to eq(property)
        end

        it "renders the edit template" do
          pending
          put_update
          expect(response).to render_template("edit")
        end
      end
    end

    context "when a valid property is not found" do
      before do
        allow(Property).to receive(:find_by).and_return(nil)
      end

      it "renders not found" do
        put :update, params: {id: "1"}
        expect(response.status).to eql 404
      end
    end
  end

  describe "POST place_in_window" do
    let(:current_user) { double(User).as_null_object }

    before do
      signed_in_user
    end

    it "finds the user's property" do
      expect(Property).to receive(:find_by)
      post "place_in_window", params: {id: "1"}
    end

    context "when the user's property is found" do
      before do
        allow(Property).to receive(:find_by).and_return(property)
      end

      it "finds the user's advert" do
        expect(Advert).to receive(:find_by)
        post "place_in_window", params: {id: "1"}
      end

      context "when an advert is found and it is a window" do
        let(:advert) { double(Advert).as_null_object }

        before do
          allow(Advert).to receive(:find_by).and_return(advert)
          allow(advert).to receive(:window?).and_return(true)
        end

        context "when it has expired" do
          before do
            allow(advert).to receive(:expired?).and_return(true)
          end

          it "sets a flash[:notice] message" do
            post "place_in_window", params: {id: "1"}
            expect(flash[:notice]).to eq("That window has expired.")
          end

          it "redirects to choose window" do
            post "place_in_window", params: {id: "1"}
            expect(response).to redirect_to(action: "choose_window")
          end
        end

        context "when it has not expired" do
          before do
            allow(advert).to receive(:expired?).and_return(false)
          end

          it "redirects to my adverts" do
            post "place_in_window", params: {id: "1"}
            expect(response).to redirect_to(my_adverts_path)
          end
        end
      end
    end
  end
end
