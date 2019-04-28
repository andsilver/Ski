require "rails_helper"

RSpec.describe "layouts/_resort_nav", type: :view do
  let(:resort) { instance_double(Resort, name: "Chamonix").as_null_object }
  before { assign(:resort, resort) }

  context "when resort has guide" do
    before { allow(resort).to receive(:has_resort_guide?).and_return(true) }

    it "links to the resort guide" do
      render
      expect(rendered).to have_content(t("layouts.resort_nav.resort_guide"))
    end
  end

  context "when resort has no guide" do
    before { allow(resort).to receive(:has_resort_guide?).and_return(false) }

    it "does not link to the resort guide" do
      render
      expect(rendered).not_to have_content(t("layouts.resort_nav.resort_guide"))
    end
  end
end
