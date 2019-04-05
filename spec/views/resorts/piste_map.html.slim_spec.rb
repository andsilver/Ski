require "rails_helper"

RSpec.describe "resorts/piste_map.html.slim", type: :view do
  let(:resort) { FactoryBot.create(:resort) }

  before do
    assign(:resort, resort)
  end

  it "renders" do
    render
  end
end
