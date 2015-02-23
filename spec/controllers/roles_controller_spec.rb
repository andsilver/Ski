require 'rails_helper'

describe RolesController do
  let(:website) { double(Website).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
  end

  describe "PUT update" do
    let(:role) { double(Role).as_null_object }
    let(:update_params) {{ id: '1', role: { name: 'A Role'}}}

    context "when signed in as admin" do
      before do
        allow(controller).to receive(:admin?).and_return(true)
        allow(Role).to receive(:find).and_return(role)
      end

      it "finds the role" do
        expect(Role).to receive(:find).with("1")
        put 'update', update_params
      end

      it "assigns @role" do
        put 'update', update_params
        expect(assigns(:role)).to eq(role)
      end

      it "updates the role" do
        expect(role).to receive(:update_attributes)
        put 'update', update_params
      end

      context "when the role updates successfully" do
        it "redirects to the edit role page" do
          allow(role).to receive(:update_attributes).and_return(true)
          put 'update', update_params
          expect(response).to redirect_to(edit_role_path(role))
        end
      end

      context "when the role doesn't update successfully" do
        it "renders the edit role page" do
          allow(role).to receive(:update_attributes).and_return(false)
          put 'update', update_params
          expect(response).to render_template('edit')
        end
      end
    end

    context "when not signed in as admin" do
      it "redirects to the sign in page" do
        allow(controller).to receive(:admin?).and_return(false)
        put 'update', update_params
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "GET sales_pitch" do
    let(:role) { mock_model(Role).as_null_object }

    it "finds the role by its SEO param" do
      expect(Role).to receive(:find_by).with(name: 'property developer')
      get 'sales_pitch', role: 'property-developer'
    end

    context "when the role exists" do
      pending
    end

    context "when the role does not exist" do
      it "renders not found" do
        allow(Role).to receive(:find_by).and_return(nil)
        put 'sales_pitch', role: 'property-developer'
        expect(response.status).to eql 404
      end
    end
  end
end
