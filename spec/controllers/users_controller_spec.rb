require 'rails_helper'

describe UsersController do
  let(:website) { double(Website).as_null_object }
  let(:user) { double(User).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
    allow(User).to receive(:new).and_return(user)
  end

  describe "GET new" do
    it "instantiates a new user" do
      expect(User).to receive(:new)
      get :new
    end

    it "assigns @user" do
      pending
      get :new
      expect(assigns[:user]).to equal(user)
    end
  end

  describe 'GET select_role' do
    it 'renders the "new" template' do
      pending
      get 'select_role', params: { user: { role_id: 1 } }
      expect(response).to render_template('new')
    end
  end

  describe "POST create" do
    let(:role) { double(Role).as_null_object }
    let(:params) { { user: { "name" => "Carey", "role_id" => "1" }} }

    before do
      allow(Role).to receive(:find_by).and_return(role)
      allow(UserNotifier).to receive_message_chain(:welcome, :deliver)
    end

    it "instantiates a new user with the given cleansed params" do
      expect(User).to receive(:new).with(params[:user].slice(:name))
      post :create, params: params
    end

    it "finds the selected role" do
      expect(Role).to receive(:find_by).with(id: '1')
      post :create, params: params
    end

    context "when the role is valid" do
      before do
        allow(role).to receive(:select_on_signup?).and_return(true)
      end

      it "assigns @user.role_id" do
        expect(user).to receive(:role_id=).with(role.id)
        post :create, params: params
      end
    end

    context "when the role is not valid" do
      before do
        allow(role).to receive(:select_on_signup?).and_return(false)
      end

      it "does not assign @user.role_id" do
        expect(user).not_to receive(:role_id=)
        post :create, params: params
      end
    end

    context "when the user saves successfully" do
      before do
        allow(user).to receive(:save).and_return(true)
        allow(user).to receive(:role).and_return(role)
      end

      it "sets a flash[:notice] message" do
        post :create, params: params
        expect(flash[:notice]).to eq("Your account was successfully created.")
      end

      context "when the user's role only advertises for sale" do
        before do
          allow(role).to receive(:only_advertises_properties_for_sale?).and_return(true)
          allow(role).to receive(:only_advertises_properties_for_rent?).and_return(false)
        end

        it "redirects to the new property for sale page" do
          post :create, params: params
          expect(response).to redirect_to(new_property_path(listing_type: Property::LISTING_TYPE_FOR_SALE))
        end
      end

      context "when the user's role only advertises for rent" do
        before do
          allow(role).to receive(:only_advertises_properties_for_sale?).and_return(false)
          allow(role).to receive(:only_advertises_properties_for_rent?).and_return(true)
        end

        it "redirects to the new property for rent page" do
          post :create, params: params
          expect(response).to redirect_to(new_property_path(listing_type: Property::LISTING_TYPE_FOR_RENT))
        end
      end

      context "when the user's role does multiple advertising" do
        before do
          allow(role).to receive(:only_advertises_properties_for_sale?).and_return(false)
          allow(role).to receive(:only_advertises_properties_for_rent?).and_return(false)
        end

        it "redirects to the first advert page" do
          post :create, params: params
          expect(response).to redirect_to(first_advert_path)
        end
      end
    end

    context "when the user fails to save" do
      before do
        allow(user).to receive(:save).and_return(false)
      end

      it "assigns @user" do
        pending
        post :create, params: params
        expect(assigns[:user]).to eq(user)
      end

      it "renders the new template" do
        pending
        post :create, params: params
        expect(response).to render_template('new')
      end
    end
  end

  describe "GET edit" do
    context 'when admin' do
      before do
        allow(controller).to receive(:signed_in?).and_return(true)
        allow(controller).to receive(:admin?).and_return(true)
      end

      it 'mentions the user\'s name in the heading' do
        pending
        u = double(User, {name: 'Jane'})
        allow(User).to receive(:find).and_return(u)
        get 'edit', params: { id: '1' }
        expect(assigns(:heading)).to eq('Jane')
      end
    end
  end

  describe 'PATCH update' do
    before do
      allow(controller).to receive(:current_user).and_return(user)
      allow(User).to receive(:find).with('1').and_return(user)
    end

    let(:update_params) {{id: '1', user: { 'first_name' => 'Fred' } }}

    context 'when the user saves' do
      context 'when admin' do
        before { signed_in_as_admin }

        it 'redirects to admin users index' do
          patch :update, params: update_params
          expect(response).to redirect_to(admin_users_path)
        end

        it 'sets a notice' do
          patch :update, params: update_params
          expect(flash.notice).to eq I18n.t('notices.saved')
        end
      end

      context 'when user' do
        before do
          signed_in
          allow(controller).to receive(:admin?).and_return(false)
        end

        it 'redirects to My Details' do
          patch :update, params: update_params
          expect(response).to redirect_to(my_details_path)
        end

        it 'sets a notice' do
          patch :update, params: update_params
          expect(flash.notice).to eq I18n.t('my_details_saved')
        end

        context 'when the user fails to update' do
          before { allow(user).to receive(:update_attributes).and_return(false) }

          it 'renders the edit template' do
            pending
            patch :update, params: update_params
            expect(response).to render_template(:edit)
          end

          it 'assigns @heading and @breadcrumbs' do
            pending
            patch :update, params: update_params
            expect(assigns(:heading)).to be
            expect(assigns(:breadcrumbs)).to be
          end
        end
      end
    end
  end
end
