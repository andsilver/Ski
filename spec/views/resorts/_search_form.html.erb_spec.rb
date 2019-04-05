require "rails_helper"

RSpec.describe "resorts/_search_form.html.erb", type: :view do
  let(:resort) { FactoryBot.create(:resort) }

  before do
    assign(:resort, resort)
  end

  context "rendered" do
    subject { rendered }
    before { render }
    it do
      should have_selector(
        "input[type=hidden][name='resort_slug'][value='#{resort.slug}']",
        visible: false
      )
    end
  end
end
