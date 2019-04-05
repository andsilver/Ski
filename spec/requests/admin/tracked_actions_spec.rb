require "rails_helper"

RSpec.describe "Tracked actions admin", type: :request do
  before do
    FactoryBot.create(:website)
    allow_any_instance_of(ApplicationController)
      .to receive(:admin?)
      .and_return(true)
  end

  describe "GET /admin/tracked_actions" do
    it "lists tracked actions in reverse chronological order" do
      da1 = FactoryBot.create(:directory_advert)
      da1.clicks << TrackedAction.new(action_type: :click, created_at: Date.new(2017, 1, 1))
      da2 = FactoryBot.create(:directory_advert)
      da2.clicks << TrackedAction.new(action_type: :click, created_at: Date.new(2017, 2, 2))

      get "/admin/tracked_actions"

      expect(response.status).to eq 200
      assert_select "tr td", text: da2.clicks.first.id.to_s
      assert_select "tr td", text: da2.to_s
      assert_select "tr + tr td", text: da1.clicks.first.id.to_s
      assert_select "tr + tr td", text: da1.to_s
    end
  end
end
