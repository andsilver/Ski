shared_examples_for "a flat namespace slug validator" do |model|
  before do
    @object = FactoryBot.build(model, slug: slug)
    @object.save
  end

  context "with valid slug" do
    let(:slug) { "valid-slug-1" }

    it "is valid" do
      expect(@object).to be_valid
    end
  end

  context "with CAPITALS" do
    let(:slug) { "ABC" }

    it "is invalid" do
      expect(@object).to be_invalid
    end
  end

  context "with slashes" do
    let(:slug) { "path/to/slug" }

    it "is invalid" do
      expect(@object).to be_invalid
    end
  end
end
