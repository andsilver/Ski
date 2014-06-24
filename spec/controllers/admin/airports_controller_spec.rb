require 'rails_helper'

describe Admin::AirportsController do
  before do
    controller.stub(:admin?).and_return(true)
    Website.stub(:first).and_return(Website.new)
  end

  describe 'GET index' do
  end
end
