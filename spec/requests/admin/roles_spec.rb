require "rails_helper"

RSpec.describe "Roles admin", type: :request do
  before do
    FactoryBot.create(:website)
    allow_any_instance_of(ApplicationController)
      .to receive(:admin?)
      .and_return(true)
  end

  describe "GET /admin/roles" do
    it "works" do
      get admin_roles_path
      expect(response).to be_ok
    end
  end

  describe "PATCH /admin/roles/:id" do
    let(:role) { FactoryBot.create(:role) }

    context "with valid params" do
      let(:update_params) do
        {id: role.id, role: {name: "New Role"}}
      end

      it "updates the role" do
        patch admin_role_path(role.id), params: update_params
        expect(role.reload.name).to eq "New Role"
      end

      it "redirects to the edit role page" do
        patch admin_role_path(role.id), params: update_params
        expect(response).to redirect_to(edit_admin_role_path(role))
      end
    end
  end
end
