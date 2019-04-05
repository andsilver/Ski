require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  let(:website) { double(Website).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
  end

  describe "GET restart" do
    before do
      signed_in_as_admin
    end

    it "runs the restart script" do
      expect(controller).to receive(:restart_script)
      get :restart
    end

    it "redirects to CMS index" do
      allow(controller).to receive(:restart_script)
      get :restart
      expect(response).to redirect_to cms_path
    end
  end

  describe "GET sitemap" do
    it "succeeds" do
      get :sitemap, format: :xml
      expect(response).to be_successful
    end
  end

  describe "bot?" do
    before { allow(controller).to receive(:bot_file).and_return("test-files/bots.txt") }

    it "returns true if bot is present in the bot file" do
      expect(controller.bot?("bot")).to be_truthy
    end

    it "returns false if bot is not present in the bot file" do
      expect(controller.bot?("browser")).to be_falsey
    end
  end
end
