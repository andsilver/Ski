require 'spec_helper'

describe PropertiesController do
  let(:property) { mock_model(Property).as_null_object }

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
