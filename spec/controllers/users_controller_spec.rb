require 'rails_helper'

describe UsersController do
  let(:website) { double(Website).as_null_object }
  let(:user) { double(User).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    User.stub(:new).and_return(user)
  end

  describe "GET new" do
    it "instantiates a new user" do
      User.should_receive(:new)
      get :new
    end

    it "assigns @user" do
      get :new
      expect(assigns[:user]).to equal(user)
    end
  end

  describe 'GET select_role' do
    it 'renders the "new" template' do
      get 'select_role', {user: {role_id: 1}}
      response.should render_template('new')
    end
  end

  describe "POST create" do
    let(:role) { double(Role).as_null_object }
    let(:params) { { user: { "name" => "Carey", "role_id" => "1" }} }

    before do
      Role.stub(:find_by).and_return(role)
      UserNotifier.stub_chain(:welcome, :deliver)
    end

    it "instantiates a new user with the given cleansed params" do
      User.should_receive(:new).with(params[:user].slice(:name))
      post :create, params
    end

    it "finds the selected role" do
      Role.should_receive(:find_by).with(id: '1')
      post :create, params
    end

    context "when the role is valid" do
      before do
        role.stub(:select_on_signup?).and_return(true)
      end

      it "assigns @user.role_id" do
        user.should_receive(:role_id=).with(role.id)
        post :create, params
      end
    end

    context "when the role is not valid" do
      before do
        role.stub(:select_on_signup?).and_return(false)
      end

      it "does not assign @user.role_id" do
        user.should_not_receive(:role_id=)
        post :create, params
      end
    end

    context "when the user saves successfully" do
      before do
        user.stub(:save).and_return(true)
        user.stub(:role).and_return(role)
      end

      it "sets a flash[:notice] message" do
        post :create, params
        expect(flash[:notice]).to eq("Your account was successfully created.")
      end

      context "when the user's role only advertises for sale" do
        before do
          role.stub(:only_advertises_properties_for_sale?).and_return(true)
          role.stub(:only_advertises_properties_for_rent?).and_return(false)
        end

        it "redirects to the new property for sale page" do
          post :create, params
          expect(response).to redirect_to(new_property_path(listing_type: Property::LISTING_TYPE_FOR_SALE))
        end
      end

      context "when the user's role only advertises for rent" do
        before do
          role.stub(:only_advertises_properties_for_sale?).and_return(false)
          role.stub(:only_advertises_properties_for_rent?).and_return(true)
        end

        it "redirects to the new property for rent page" do
          post :create, params
          expect(response).to redirect_to(new_property_path(listing_type: Property::LISTING_TYPE_FOR_RENT))
        end
      end

      context "when the user's role does multiple advertising" do
        before do
          role.stub(:only_advertises_properties_for_sale?).and_return(false)
          role.stub(:only_advertises_properties_for_rent?).and_return(false)
        end

        it "redirects to the first advert page" do
          post :create, params
          expect(response).to redirect_to(first_advert_path)
        end
      end
    end

    context "when the user fails to save" do
      before do
        user.stub(:save).and_return(false)
      end

      it "assigns @user" do
        post :create, params
        expect(assigns[:user]).to eq(user)
      end

      it "renders the new template" do
        post :create, params
        expect(response).to render_template('new')
      end
    end
  end

  describe "GET edit" do
    context 'when admin' do
      before do
        controller.stub(:signed_in?).and_return(true)
        controller.stub(:admin?).and_return(true)
      end

      it 'mentions the user\'s name in the heading' do
        u = double(User, {name: 'Jane'})
        User.stub(:find).and_return(u)
        get 'edit', id: '1'
        expect(assigns(:heading)).to eq('Jane')
      end
    end
  end

  describe 'PATCH update' do
    before do
      controller.stub(:current_user).and_return(user)
      User.stub(:find).with('1').and_return(user)
    end

    let(:update_params) {{id: '1', user: { 'first_name' => 'Fred' } }}

    context 'when the user saves' do
      context 'when admin' do
        before { signed_in_as_admin }

        it 'redirects to admin users index' do
          patch :update, update_params
          expect(response).to redirect_to(admin_users_path)
        end

        it 'sets a notice' do
          patch :update, update_params
          expect(flash.notice).to eq I18n.t('notices.saved')
        end
      end

      context 'when user' do
        before do
          signed_in
          controller.stub(:admin?).and_return(false)
        end

        it 'redirects to My Details' do
          patch :update, update_params
          expect(response).to redirect_to(my_details_path)
        end

        it 'sets a notice' do
          patch :update, update_params
          expect(flash.notice).to eq I18n.t('my_details_saved')
        end

        context 'when the user fails to update' do
          before { user.stub(:update_attributes).and_return(false) }

          it 'renders the edit template' do
            patch :update, update_params
            expect(response).to render_template(:edit)
          end

          it 'assigns @heading and @breadcrumbs' do
            patch :update, update_params
            expect(assigns(:heading)).to be
            expect(assigns(:breadcrumbs)).to be
          end
        end
      end
    end
  end
end
