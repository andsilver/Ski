require 'spec_helper'

describe CountriesController do
  let(:website) { mock_model(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

  def mock_country
    @mock_country ||= mock_model(Country)
  end

  describe 'GET show' do
    pending
  end
end
