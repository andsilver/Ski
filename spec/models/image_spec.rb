require 'spec_helper'

describe Image do
  it { should respond_to(:source_url) }

  describe "#determine_filename" do
    context "when file data is supplied" do
      let(:file_data) { double(Object).as_null_object }

      context "when file data responds to original_filename" do
        it "sets its filename to the image.<ext> where <ext> is the lowercased uploaded file extension" do
          file_data.stub(:original_filename).and_return('apple.banana.JPEG')
          i = Image.new
          i.image = file_data
          expect(i.determine_filename).to eq('image.jpeg')
          expect(i.filename).to eq('image.jpeg')
        end
      end

      context "when file data doesn't respond to original_filename" do
        it "sets its filename to the image.jpg" do
          file_data.stub(:respond_to?).with('original_filename').and_return(false)
          i = Image.new
          i.image = file_data
          expect(i.determine_filename).to eq('image.jpg')
          expect(i.filename).to eq('image.jpg')
        end
      end
    end

    context "when source_url is set instead of file data" do
      it "sets its filename to image.jpg" do
        i = Image.new
        i.source_url = 'http://www.example.org/image.png'
        expect(i.determine_filename).to eq('image.jpg')
        expect(i.filename).to eq('image.jpg')
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
    it "returns the source URL if it's a remote image" do
      i = Image.new(source_url: 'http://www.example.org/image.jpg')
      i.stub(:remote_image?).and_return(true)
      expect(i.url).to eq 'http://www.example.org/image.jpg'
    end
  end

  describe "#sized_url" do
    it "returns the source URL if it's a remote image" do
      i = Image.new(source_url: 'http://www.example.org/image.jpg')
      i.stub(:filename).and_return('image.jpg')
      i.stub(:remote_image?).and_return(true)
      expect(i.sized_url(100, :longest_side)).to eq 'http://www.example.org/image.jpg'
    end
  end

  describe "#remote_image?" do
    it "returns true if the file doesn't exist and the source URL is not blank" do
      i = Image.new
      i.source_url = 'http://www.example.org/image.jpeg'
      FileTest.stub(:exist?).and_return(false)
      expect(i.remote_image?).to be_true
    end

    it "returns false if the file exists" do
      i = Image.new
      i.source_url = 'http://www.example.org/image.jpeg'
      FileTest.stub(:exist?).and_return(true)
      expect(i.remote_image?).to be_false
    end

    it "returns false if the source URL is blank" do
      i = Image.new
      FileTest.stub(:exist?).and_return(true)
      expect(i.remote_image?).to be_false
    end
  end
end
