shared_examples_for "a property header image" do
  include ViewSpecHelpers

  before { assign(:property, property) }

  context "without an image" do
    before { property.image = nil }

    it "does not display a header image" do
      render
      expect(response).not_to have_selector(".header-image")
    end
  end

  context "with an image" do
    before { property.image = FactoryBot.create(:image) }

    it "displays the main property image as a header image" do
      render
      within(".header-image") do |header_image|
        expect(header_image).to have_selector "img"
      end
    end
  end
end
