require "rails_helper"

RSpec.describe SearchController, type: :controller do
  let(:website) { double(Website).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
  end

  describe "GET #place_names" do
    let(:region) { FactoryBot.create(:region, name: "Lake Como", property_count: 2) }
    let(:resort1) { FactoryBot.create(:resort, name: "Zel am See", property_count: 3) }
    let(:resort2) { FactoryBot.create(:resort, visible: 0) }
    let(:resort3) { FactoryBot.create(:resort, name: "Chamonix", property_count: 0) }

    render_views

    it "returns the names of regions and visible resorts in alphabetical order" do
      get :place_names
      JSON.parse(response.body) == [
        {name: "Chamonix", count: 0},
        {name: "Lake Como", count: 2},
        {name: "Zel am See", count: 3},
      ]
    end
  end
end
