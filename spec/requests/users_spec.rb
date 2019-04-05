require "rails_helper"

RSpec.describe "Users", type: :request do
  before { FactoryBot.create(:website) }

  describe "GET /users/new" do
    it "renders a form to select account type" do
      get new_user_path
      assert_select "form[action='#{users_path}']" do
        assert_select "select[name='user[role_id]']"
      end
    end
  end

  describe "GET /users/select_role" do
    let(:role) { FactoryBot.create(:role) }

    it "renders the user sign-up form" do
      get "/users/select_role", params: {user: {role_id: role.id}}
      assert_select "form[action='#{users_path}']"
    end
  end

  describe "POST /users" do
    let(:select_on_signup) { true }
    let(:role) { FactoryBot.create(:role, select_on_signup: select_on_signup) }
    let(:role_id) { role.id }
    let(:params) do
      {
        user: {
          first_name: "Alice", last_name: "Smith", role_id: role_id,
        },
      }
    end

    before do
      allow(UserNotifier).to receive_message_chain(:welcome, :deliver)
    end

    def perform
      post users_path, params: params
    end

    context "without a role" do
      let(:role_id) { nil }
      it "renders a form to choose an account type" do
        perform
        assert_select "form[action='#{users_path}']" do
          assert_select "input[type=hidden][name='stage'][value='1']"
        end
      end
    end

    context "with a valid role and no other details, or no valid details" do
      it "renders a sign-up form" do
        perform
        assert_select "form[action='#{users_path}']" do
          assert_select(
            "input[type=hidden][name='user[role_id]'][value='#{role_id}']"
          )
          assert_select "input[name='user[first_name]']"
          assert_select "input[name='user[last_name]']"
        end
      end
    end

    context "with an invalid role" do
      let(:select_on_signup) { false }
      it "renders a form to choose an account type" do
        perform
        assert_select "form[action='#{users_path}']" do
          assert_select "input[type=hidden][name='stage'][value='1']"
        end
      end
    end

    context "with full valid details" do
      let(:country) { FactoryBot.create(:country) }
      let(:params) do
        {
          user: {
            role_id: role.id,
            first_name: "Alice",
            last_name: "Smith",
            email: "alice@example.org",
            password: "secret",
            phone: "123456",
            billing_street: "b street",
            billing_city: "b city",
            billing_country_id: country.id,
            terms_and_conditions: "1",
          },
        }
      end

      it "creates the user" do
        perform
        user = User.last
        expect(user).to be
        expect(user.role).to eq role
        expect(user.first_name).to eq "Alice"
        expect(user.last_name).to eq "Smith"
        expect(user.email).to eq "alice@example.org"
        expect(user.phone).to eq "123456"
        expect(user.billing_street).to eq "b street"
        expect(user.billing_city).to eq "b city"
        expect(user.billing_country).to eq country
      end

      it "sets a flash notice" do
        perform
        expect(flash[:notice]).to eq("Your account was successfully created.")
      end

      context "when the user's role only advertises for sale" do
        before do
          allow_any_instance_of(Role)
            .to receive(:only_advertises_properties_for_sale?).and_return(true)
          allow_any_instance_of(Role)
            .to receive(:only_advertises_properties_for_rent?).and_return(false)
        end

        it "redirects to the new property for sale page" do
          perform
          expect(response).to redirect_to(
            new_property_path(listing_type: Property::LISTING_TYPE_FOR_SALE)
          )
        end
      end

      context "when the user's role only advertises for rent" do
        before do
          allow_any_instance_of(Role)
            .to receive(:only_advertises_properties_for_sale?).and_return(false)
          allow_any_instance_of(Role)
            .to receive(:only_advertises_properties_for_rent?).and_return(true)
        end

        it "redirects to the new property for rent page" do
          perform
          expect(response).to redirect_to(
            new_property_path(listing_type: Property::LISTING_TYPE_FOR_RENT)
          )
        end
      end

      context "when the user's role does multiple advertising" do
        before do
          allow_any_instance_of(Role)
            .to receive(:only_advertises_properties_for_sale?).and_return(false)
          allow_any_instance_of(Role)
            .to receive(:only_advertises_properties_for_rent?).and_return(false)
        end

        it "redirects to the first advert page" do
          perform
          expect(response).to redirect_to(first_advert_path)
        end
      end
    end
  end

  describe "GET /users/:id/edit" do
    context "when admin" do
      before do
        allow_any_instance_of(ApplicationController)
          .to receive(:current_user).and_return(FactoryBot.create(:admin_user))
      end

      it "mentions the user's name in the heading" do
        user = FactoryBot.create(:user, first_name: "Alice", last_name: "Smith")
        get edit_user_path(user)
        assert_select "li.active", text: "Alice Smith"
      end
    end
  end
end
