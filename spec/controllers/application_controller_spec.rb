require 'spec_helper'

describe ApplicationController do
  let(:website) { mock_model(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

  describe 'GET sitemap' do
    it 'succeeds' do
      get :sitemap, format: :xml
      expect(response).to be_successful
    end
  end
end
