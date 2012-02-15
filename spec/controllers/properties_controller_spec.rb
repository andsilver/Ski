require 'spec_helper'

describe PropertiesController do
  let(:property) { mock_model(Property).as_null_object }
  let(:website) { mock_model(Website).as_null_object }
  let(:resort) { mock_model(Resort).as_null_object }
  let(:non_admin_role) { mock_model(Role).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    Resort.stub(:find).and_return(resort)
    non_admin_role.stub(:admin?).and_return(false)
  end

  describe "GET new_developments" do
    let(:properties) { mock(ActiveRecord::Relation).as_null_object }

    before do
      Property.stub(:paginate).and_return(properties)
    end

    it "finds paginated properties" do
      Property.should_receive(:paginate)
      get :new_developments, :resort_id => "1"
    end

    it "finds new developments" do
      Property.should_receive(:paginate).with(hash_including(:conditions => [PropertiesController::CURRENTLY_ADVERTISED[0] + " AND resort_id = ? AND new_development = 1", "1"]))
      get :new_developments, :resort_id => "1"
    end

    it "assigns @properties" do
      get :new_developments, :resort_id => "1"
      assigns[:properties].should equal(properties)
    end
  end

  describe "GET new" do
    let(:current_user) { mock_model(User).as_null_object }

    before do
      session[:user] = 1
      User.stub(:find_by_id).and_return(current_user)
      Property.stub(:new).and_return(property)
    end

    it "instantiates a new property" do
      Property.should_receive(:new)
      get :new
    end

    context "with params[:for_sale] set" do
      it "sets property.for_sale to true" do
        property.should_receive(:for_sale=).with(true)
        get :new, :for_sale => ""
      end
    end

    context "with params[:for_sale] not set" do
      it "doesn't set property.for_sale" do
        property.should_not_receive(:for_sale=)
        get :new
      end
    end
  end

  describe "POST create" do
    let(:current_user) { mock_model(User).as_null_object }
    let(:role) { mock_model(Role).as_null_object }

    before do
      session[:user] = 1
      Advert.stub(:create_for)
      User.stub(:find_by_id).and_return(current_user)
      current_user.stub(:role).and_return(role)
      Property.stub(:new).and_return(property)
      property.stub(:user_id).and_return(1)
    end

    context "when the property saves successfully" do
      before do
        property.stub(:save).and_return(true)
      end

      context "when advertising through windows" do
        pending
      end

      context "when not advertising through windows" do
        before do
          role.stub(:advertises_through_windows?).and_return(false)
          current_user.role = role
        end

        it "creates a corresponding advert" do
          Advert.should_receive(:create_for).with(property)
          post :create
        end
      end

      it "redirects to image uploading form" do
        post :create
        response.should redirect_to(new_image_path)
      end
    end
  end

  describe "GET show" do
    it "finds a property" do
      Property.should_receive(:find_by_id).with("1")
      get :show, :id => "1"
    end

    context "when a property is found" do
      let(:property) { mock_model(Property).as_null_object }
      let(:enquiry) { mock_model(Enquiry).as_null_object }

      before do
        Property.stub(:find_by_id).and_return(property)
        Enquiry.stub(:new).and_return(enquiry)
      end

      it "assigns @property" do
        get :show, :id => "1"
        assigns[:property].should equal(property)
      end
    end

    context "when a property is not found" do
      before do
        Property.stub(:find_by_id).and_return(nil)
      end

      it "renders not found" do
        get :show, { :id => 1 }
        response.status.should eql 404
      end
    end
  end

  def find_a_property_belonging_to_the_current_user
    Property.should_receive(:find_by_id_and_user_id).with("1", anything())
  end

  def signed_in_user
    session[:user] = 1
    User.stub(:find_by_id).and_return(current_user)

    current_user.stub(:role).and_return(non_admin_role)
  end

  describe "GET edit" do
    let(:current_user) { mock_model(User).as_null_object }
    let(:property) { mock_model(Property).as_null_object }

    before do
      signed_in_user
    end

    it "finds a property belonging to the current user" do
      find_a_property_belonging_to_the_current_user
      get :edit, { :id => "1" }
    end

    context "when a valid_property is found" do
      before do
        Property.stub(:find_by_id_and_user_id).and_return(property)
      end

      it "assigns @property" do
        get :edit, :id => "1"
        assigns[:property].should equal(property)
      end
    end

    context "when a valid_property is not found" do
      before do
        Property.stub(:find_by_id_and_user_id).and_return(nil)
      end

      it "renders not found" do
        get :edit, { :id => 1 }
        response.status.should eql 404
      end
    end
  end

  describe "PUT update" do
    let(:current_user) { mock_model(User).as_null_object }

    before do
      signed_in_user
    end

    it "finds a property belonging to the current user" do
      find_a_property_belonging_to_the_current_user
      put :update, { :id => "1" }
    end

    context "when a valid property is found" do
      let(:property) { mock_model(Property).as_null_object }

      before do
        Property.stub(:find_by_id_and_user_id).and_return(property)
      end

      context "when the property updates successfully" do
        before do
          property.stub(:update_attributes).and_return(true)
        end

        it "redirects to my adverts page" do
          property.stub(:for_sale?).and_return(false)
          put :update, { :id => "1" }
          response.should redirect_to(my_adverts_path)
        end

        it "sets a flash[:notice] message" do
          put :update, { :id => "1" }
          flash[:notice].should eq("Your property advert details have been saved.")
        end
      end

      context "when the property fails to update" do
        before do
          property.stub(:update_attributes).and_return(false)
        end

        it "assigns @property" do
          put :update, { :id => "1" }
          assigns[:property].should eq(property)
        end

        it "renders the edit template" do
          put :update, { :id => "1" }
          response.should render_template("edit")
        end
      end
    end

    context "when a valid property is not found" do
      before do
        Property.stub(:find_by_id_and_user_id).and_return(nil)
      end

      it "renders not found" do
        put :update, { :id => 1 }
        response.status.should eql 404
      end
    end
  end
end
