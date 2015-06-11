require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let(:website) { double(Website).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
  end

  describe 'GET #place_names' do
    let(:region) { FactoryGirl.create(:region, name: 'Lake Como') }
    let(:resort1) { FactoryGirl.create(:resort, name: 'Zel am See') }
    let(:resort2) { FactoryGirl.create(:resort, visible: 0) }
    let(:resort3) { FactoryGirl.create(:resort, name: 'Chamonix') }

    render_views

    it 'returns the names of regions and visible resorts in alphabetical order' do
      get :place_names
      JSON.parse(response.body) == ['Chamonix', 'Lake Como', 'Zel am See']
    end
  end
end
