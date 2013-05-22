require 'spec_helper'

describe RolesController do
  let(:website) { mock_model(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

  describe "PUT update" do
    let(:role) { mock_model(Role).as_null_object }
    let(:update_params) {{ id: '1', role: { name: 'A Role'}}}

    context "when signed in as admin" do
      before do
        controller.stub(:admin?).and_return(true)
        Role.stub(:find).and_return(role)
      end

      it "finds the role" do
        Role.should_receive(:find).with("1")
        put 'update', update_params
      end

      it "assigns @role" do
        put 'update', update_params
        expect(assigns(:role)).to eq(role)
      end

      it "updates the role" do
        role.should_receive(:update_attributes)
        put 'update', update_params
      end

      context "when the role updates successfully" do
        it "redirects to the edit role page" do
          role.stub(:update_attributes).and_return(true)
          put 'update', update_params
          expect(response).to redirect_to(edit_role_path(role))
        end
      end

      context "when the role doesn't update successfully" do
        it "renders the edit role page" do
          role.stub(:update_attributes).and_return(false)
          put 'update', update_params
          expect(response).to render_template('edit')
        end
      end
    end

    context "when not signed in as admin" do
      it "redirects to the sign in page" do
        controller.stub(:admin?).and_return(false)
        put 'update', update_params
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "GET sales_pitch" do
    let(:role) { mock_model(Role).as_null_object }

    it "finds the role by its SEO param" do
      Role.should_receive(:find_by_name).with('property developer')
      get 'sales_pitch', role: 'property-developer'
    end

    context "when the role exists" do
      pending
    end

    context "when the role does not exist" do
      it "renders not found" do
        Role.stub(:find_by_name).and_return(nil)
        put 'sales_pitch', role: 'property-developer'
        expect(response.status).to eql 404
      end
    end
  end
end
