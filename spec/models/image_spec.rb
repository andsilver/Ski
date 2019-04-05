require "rails_helper"

describe Image do
  it { should respond_to(:source_url) }

  describe "#determine_filename" do
    context "when file data is supplied" do
      let(:file_data) { double(Object).as_null_object }

      context "when file data responds to original_filename" do
        it "sets its filename to the image.<ext> where <ext> is the lowercased uploaded file extension" do
          allow(file_data).to receive(:original_filename).and_return("apple.banana.JPEG")
          i = Image.new
          i.image = file_data
          expect(i.determine_filename).to eq("image.jpeg")
          expect(i.filename).to eq("image.jpeg")
        end
      end

      context "when file data doesn't respond to original_filename" do
        it "sets its filename to the image.jpg" do
          allow(file_data).to receive(:respond_to?).with("original_filename").and_return(false)
          i = Image.new
          i.image = file_data
          expect(i.determine_filename).to eq("image.jpg")
          expect(i.filename).to eq("image.jpg")
        end
      end
    end

    context "when source_url is set instead of file data" do
      it "sets its filename to image.jpg" do
        i = Image.new
        i.source_url = "http://www.example.org/image.png"
        expect(i.determine_filename).to eq("image.jpg")
        expect(i.filename).to eq("image.jpg")
      end
    end

    context "when neither file data nor source_url supplied" do
      it "raises an exception" do
        i = Image.new
        expect {i.determine_filename}.to raise_error(RuntimeError)
      end
    end
  end

  describe "#url" do
    it "downloads the image from the source URL if needed" do
      i = Image.new
      expect(i).to receive(:download_from_source_if_needed)
      i.url
    end
  end

  describe "#size_original!" do
    let(:image)         { Image.new }
    let(:original_path) { "test-files/original-image.jpg" }
    let(:sized_path)    { "test-files/sized-image.jpg" }
    let(:random)        { SecureRandom.hex }

    before do
      allow(image).to receive(:sized_url)
      allow(image).to receive(:sized_path).and_return(sized_path)

      FileUtils.touch(original_path)
      File.open(sized_path, "w") {|f| f.write(random) }
      allow(image).to receive(:original_path).and_return(original_path)
    end

    after do
      FileUtils.rm(original_path) if File.exist?(original_path)
      FileUtils.rm(sized_path)    if File.exist?(sized_path)
    end

    it "passes the method and size params to sized_url along with force_local option" do
      expect(image).to receive(:sized_url).with(200, :maxpect, force_local: true)
      image.size_original!(200, :maxpect)
    end

    context "when was_sized" do
      before { allow(image).to receive(:was_sized).and_return(true) }

      it "replaces the original file with the sized file" do
        image.size_original!(100, :longest_side)
        expect(IO.read(original_path)).to eq random
      end

      it "leaves the sized file intact" do
        image.size_original!(100, :longest_side)
        expect(IO.read(sized_path)).to eq random
      end
    end

    context "when not was_sized" do
      before { allow(image).to receive(:was_sized).and_return(false) }

      it "leaves the original file intact" do
        original_random = SecureRandom.hex
        File.open(original_path, "w") {|f| f.write(original_random) }
        image.size_original!(100, :longest_side)
        expect(IO.read(original_path)).to eq original_random
      end
    end
  end

  describe "#sized_url" do
    it "downloads the image from the source URL if needed" do
      i = Image.new
      allow(i).to receive(:filename).and_return("image.jpg")
      expect(i).to receive(:download_from_source_if_needed)
      i.sized_url(100, :longest_side)
    end

    describe "was_sized flag" do
      let(:i) { Image.new(source_url: "http://www.example.org/image.jpg") }

      before do
        allow(ImageScience).to receive(:with_image)
        allow(i).to receive(:filename).and_return("image.jpg")
      end

      context "previously unset" do
        before { i.instance_variable_set(:@was_sized, false) }

        it "sets to true when sized" do
          allow(i).to receive(:remote_image?).and_return(false)
          allow(FileTest).to receive(:exist?).and_return true
          allow(File).to receive(:size).and_return 1
          i.sized_url(100, :longest_side)
          expect(i.was_sized).to be_truthy
        end
      end

      context "previously set" do
        before { i.instance_variable_set(:@was_sized, true) }

        it "sets to false when remote" do
          allow(i).to receive(:remote_image?).and_return(true)
          i.sized_url(100, :longest_side)
          expect(i.was_sized).to be_falsey
        end

        it "sets to false when file missing" do
          allow(i).to receive(:remote_image?).and_return(false)
          allow(File).to receive(:exist?).and_return false
          i.sized_url(100, :longest_side)
          expect(i.was_sized).to be_falsey
        end
      end
    end
  end

  describe "#sized_filename" do
    let(:image) { Image.new }

    before { allow(image).to receive(:extension).and_return("jpg") }

    it "contains the method, size and extension" do
      expect(image.sized_filename(100, :longest_side)).to eq "longest_side_100.jpg"
    end

    it "handles size as an [x,y] array" do
      expect(image.sized_filename([50, 100], :longest_side)).to eq "longest_side_50x100.jpg"
    end
  end

  describe "#download_from_source_if_needed" do
    context "when the image does not exist and source_url is set" do
      it "downloads the image from source" do
        allow(FileTest).to receive(:exist?).and_return(false)
        i = Image.new
        i.source_url = "http://example.org"
        expect(i).to receive(:download_from_source)
        i.download_from_source_if_needed
      end
    end

    context "when the image exists" do
      it "does nothing" do
        allow(FileTest).to receive(:exist?).and_return(true)
        i = Image.new
        expect(i).not_to receive(:download_from_source)
        i.download_from_source_if_needed
      end
    end

    context "when the source_url is not set" do
      it "does nothing" do
        i = Image.new
        expect(i).not_to receive(:download_from_source)
        i.download_from_source_if_needed
      end
    end
  end

  describe "#remote_image?" do
    it "returns true if the file doesn't exist and the source URL is not blank" do
      i = Image.new
      i.source_url = "http://www.example.org/image.jpeg"
      allow(FileTest).to receive(:exist?).and_return(false)
      expect(i.remote_image?).to be_truthy
    end

    it "returns false if the file exists" do
      i = Image.new
      i.source_url = "http://www.example.org/image.jpeg"
      allow(FileTest).to receive(:exist?).and_return(true)
      expect(i.remote_image?).to be_falsey
    end

    it "returns false if the source URL is blank" do
      i = Image.new
      allow(FileTest).to receive(:exist?).and_return(true)
      expect(i.remote_image?).to be_falsey
    end
  end
end
