require "rails_helper"

describe SnippetFileSystem do
  describe "#read_template_file" do
    it "retrieves snippet source from English snippet matching the name" do
      Snippet.create!(name: "foo", snippet: "{{ bar }}", locale: "en")
      expect(SnippetFileSystem.new.read_template_file("foo", "context"))
        .to eq "{{ bar }}"
    end
  end
end
