require 'rails_helper'

describe ApplicationController do
  let(:website) { double(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

  describe 'GET sitemap' do
    it 'succeeds' do
      get :sitemap, format: :xml
      expect(response).to be_successful
    end
  end

  describe 'bot?' do
    before { controller.stub(:bot_file).and_return('test-files/bots.txt') }

    it 'returns true if bot is present in the bot file' do
      expect(controller.bot?('bot')).to be_truthy
    end

    it 'returns false if bot is not present in the bot file' do
      expect(controller.bot?('browser')).to be_falsey
    end
  end
end
