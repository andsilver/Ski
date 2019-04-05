require "rails_helper"

describe ApplicationHelper do
  describe "#md" do
    it "returns HTML from Markdown formatted text" do
      expect(helper.md("# Heading")).to eq "<h1>Heading</h1>\n"
    end

    it "returns a blank string when passed nil" do
      expect(helper.md(nil)).to eq ""
    end
  end
end
