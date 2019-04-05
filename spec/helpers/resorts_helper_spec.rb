require "rails_helper"

RSpec.describe ResortsHelper, type: :helper do
  describe "#images_in_directory" do
    it "returns filenames that could be images" do
      allow(Dir).to receive(:entries).and_return([".", "..", "image.jpg", "ignore"])
      expect(images_in_directory("some/dir")).to eq ["image.jpg"]
    end

    it "returns sorted filenames" do
      allow(Dir).to receive(:entries).and_return(["z.jpg", "a.jpg"])
      expect(images_in_directory("some/dir")).to eq ["a.jpg", "z.jpg"]
    end

    it "returns empty array when directory missing" do
      expect(images_in_directory("nonexistent")).to eq []
    end
  end

  describe "#header_image_urls" do
    before do
      assign(:region, region)
    end

    context "with only region set" do
      let(:region) { FactoryBot.build(:region) }

      it "returns header image URLs for regions" do
        urls = ["/path/to/r1.jpg"]
        expect(helper).to receive(:region_header_urls).and_return urls
        expect(helper.header_image_urls).to eq urls
      end
    end
  end

  describe "#region_header_urls" do
    before do
      assign(:region, region)
    end

    context "when @region set" do
      let(:region) { FactoryBot.build(:region) }

      before do
        allow(helper).to receive(:region_images).and_return ["r1.jpg"]
        allow(controller).to receive(:action_name).and_return action_name
      end

      context "when on how-to-get-there page" do
        let(:action_name) { "how_to_get_there" }

        it "returns an array of region header URLs" do
          expect(helper.region_header_urls).to eq ["/regions/#{region.name.parameterize}/headers/r1.jpg"]
        end
      end

      context "when on other pages" do
        let(:action_name) { "show" }

        it "returns nil" do
          expect(helper.region_header_urls).to be_nil
        end
      end
    end

    context "when @region not set" do
      let(:region) { nil }

      it "returns nil" do
        expect(helper.region_header_urls).to be_nil
      end
    end
  end
end
