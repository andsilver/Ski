require 'rails_helper'

describe Admin::AirportsController do
  before do
    allow(controller).to receive(:admin?).and_return(true)
    allow(Website).to receive(:first).and_return(Website.new)
  end

  describe 'GET index' do
  end
end
