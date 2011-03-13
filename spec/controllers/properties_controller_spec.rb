require 'spec_helper'

describe PropertiesController do
  let(:property) { mock_model(Property).as_null_object }

  describe "GET new_developments" do
    let(:properties) { mock(ActiveRecord::Relation).as_null_object }

    before do
      Property.stub(:paginate).and_return(properties)
    end

    it "finds paginated properties ordered by when created" do
      Property.should_receive(:paginate).with(hash_including(:order => "created_at DESC"))
      get :new_developments
    end

    it "finds new developments" do
      Property.should_receive(:paginate).with(hash_including(:conditions => {:new_development => true}))
      get :new_developments
    end

    it "assigns @properties" do
      get :new_developments
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

      it "instantiates a new enquiry" do
        Enquiry.should_receive(:new)
        get :show, :id => "1"
      end

      it "assigns @enquiry" do
        get :show, :id => "1"
        assigns[:enquiry].should equal(enquiry)
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

  describe "PUT update" do
    let(:current_user) { mock_model(User).as_null_object }

    before do
      session[:user] = 1
      User.stub(:find_by_id).and_return(current_user)
    end

    it "finds a property" do
      Property.should_receive(:find_by_id_and_user_id).with("1", anything())
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

        it "redirects to the updated property" do
          put :update, { :id => "1" }
          response.should redirect_to(property_path(property))
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
