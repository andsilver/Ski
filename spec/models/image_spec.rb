require 'spec_helper'

describe Image do
  it { should respond_to(:source_url) }

  describe "#determine_filename" do
    context "when file data is supplied" do
      let(:file_data) { mock(Object).as_null_object }

      context "when file data responds to original_filename" do
        it "sets its filename to the image.<ext> where <ext> is the lowercased uploaded file extension" do
          file_data.stub(:original_filename).and_return('apple.banana.JPEG')
          i = Image.new
          i.image = file_data
          i.determine_filename.should eq('image.jpeg')
          i.filename.should eq('image.jpeg')
        end
      end

      context "when file data doesn't respond to original_filename" do
        it "sets its filename to the image.jpg" do
          file_data.stub(:respond_to?).with('original_filename').and_return(false)
          i = Image.new
          i.image = file_data
          i.determine_filename.should eq('image.jpg')
          i.filename.should eq('image.jpg')
        end
      end
    end

    context "when source_url is set instead of file data" do
      it "sets its filename to image.jpg" do
        i = Image.new
        i.source_url = 'http://www.example.org/image.png'
        i.determine_filename.should eq('image.jpg')
        i.filename.should eq('image.jpg')
      end
    end

    context "when neither file data nor source_url supplied" do
      it "raises an exception" do
        i = Image.new
        lambda {i.determine_filename}.should raise_error(RuntimeError)
      end
    end
  end

  describe "#url" do
    it "downloads the image from the source URL if needed" do
      i = Image.new
      i.should_receive(:download_from_source_if_needed)
      i.url
    end
  end

  describe "#sized_url" do
    it "downloads the image from the source URL if needed" do
      i = Image.new
      i.stub(:filename).and_return('image.jpg')
      i.should_receive(:download_from_source_if_needed)
      i.sized_url(100, :longest_side)
    end
  end

  describe "#download_from_source_if_needed" do
    context "when the image does not exist and source_url is set" do
      it "downloads the image from source" do
        FileTest.stub(:exists?).and_return(false)
        i = Image.new
        i.source_url = 'http://example.org'
        i.should_receive(:download_from_source)
        i.download_from_source_if_needed
      end
    end

    context "when the image exists" do
      it "does nothing" do
        FileTest.stub(:exists?).and_return(true)
        i = Image.new
        i.should_not_receive(:download_from_source)
        i.download_from_source_if_needed
      end
    end

    context "when the source_url is not set" do
      it "does nothing" do
        i = Image.new
        i.should_not_receive(:download_from_source)
        i.download_from_source_if_needed
      end
    end
  end
end
