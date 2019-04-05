require "rails_helper"

RSpec.describe "Buying guides admin", type: :request do
  before do
    FactoryBot.create(:website)
    allow_any_instance_of(ApplicationController)
      .to receive(:admin?)
      .and_return(true)
  end

  describe "GET /admin/buying_guides/new" do
    it "renders a form" do
      get new_admin_buying_guide_path
      assert_select "form[action='#{admin_buying_guides_path}']"
    end
  end
end
