require "rails_helper"

RSpec.describe "Buying guides", type: :request do
  before { FactoryBot.create(:website) }

  describe "GET /buying_guides/:id" do
    it "displays the buying guide content" do
      guide = FactoryBot.create(
        :buying_guide, content: "Buying property in Chamoninx"
      )

      get buying_guide_path(guide)

      assert_select ".buying-guide-content", text: guide.content
    end

    context "when guide does not exist" do
      it "responds not found" do
        get buying_guide_path(id: 2)
        expect(response).to be_not_found
      end
    end
  end
end
