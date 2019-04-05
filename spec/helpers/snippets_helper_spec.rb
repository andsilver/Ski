# frozen_string_literal: true

require "rails_helper"

RSpec.describe SnippetsHelper, type: :helper do
  describe "#snippet" do
    before do
      @lang = "en"
      Snippet.create!(name: "found", snippet: "copy", locale: @lang)
    end

    it "returns the snippet contents matching name and @lang" do
      expect(snippet("found", "default")).to eq "copy"
    end

    it "sanitizes the HTML" do
      expect(snippet("found", "default").html_safe?).to be_truthy
    end

    it "returns the default string when no snippet is found" do
      expect(snippet("nonexistent", "default")).to eq "default"
    end
  end
end
