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

  describe '#size_original!' do
    let(:image)         { Image.new }
    let(:original_path) { 'test-files/original-image.jpg' }
    let(:sized_path)    { 'test-files/sized-image.jpg' }
    let(:random)        { SecureRandom.hex }

    before do
      image.stub(:sized_url)
      image.stub(:sized_path).and_return(sized_path)

      FileUtils.touch(original_path)
      File.open(sized_path, 'w') {|f| f.write(random) }
      image.stub(:original_path).and_return(original_path)
    end

    after do
      FileUtils.rm(original_path) if File.exist?(original_path)
      FileUtils.rm(sized_path)    if File.exist?(sized_path)
    end

    it 'passes the method and size params to sized_url along with force_local option' do
      image.should_receive(:sized_url).with(200, :maxpect, force_local: true)
      image.size_original!(200, :maxpect)
    end

    context 'when was_sized' do
      before { image.stub(:was_sized).and_return(true) }

      it 'replaces the original file with the sized file' do
        image.size_original!(100, :longest_side)
        expect(IO.read(original_path)).to eq random
      end

      it 'leaves the sized file intact' do
        image.size_original!(100, :longest_side)
        expect(IO.read(sized_path)).to eq random
      end
    end

    context 'when not was_sized' do
      before { image.stub(:was_sized).and_return(false) }

      it 'leaves the original file intact' do
        original_random = SecureRandom.hex
        File.open(original_path, 'w') {|f| f.write(original_random) }
        image.size_original!(100, :longest_side)
        expect(IO.read(original_path)).to eq original_random
      end
    end
  end

  describe "#sized_url" do
    it "returns the source URL if it's a remote image" do
      i = Image.new(source_url: 'http://www.example.org/image.jpg')
      i.stub(:filename).and_return('image.jpg')
      i.stub(:remote_image?).and_return(true)
      expect(i.sized_url(100, :longest_side)).to eq 'http://www.example.org/image.jpg'
    end

    describe 'was_sized flag' do
      let(:i) { Image.new(source_url: 'http://www.example.org/image.jpg') }

      before do
        ImageScience.stub(:with_image)        
        i.stub(:filename).and_return('image.jpg')
      end

      context 'previously unset' do
        before { i.instance_variable_set(:@was_sized, false) }

        it 'sets to true when sized' do
          i.stub(:remote_image?).and_return(false)
          File.stub(:exist?).and_return true
          i.sized_url(100, :longest_side)
          expect(i.was_sized).to be_true
        end
      end

      context 'previously set' do
        before { i.instance_variable_set(:@was_sized, true) }

        it 'sets to false when remote' do
          i.stub(:remote_image?).and_return(true)
          i.sized_url(100, :longest_side)
          expect(i.was_sized).to be_false
        end

        it 'sets to false when file missing' do
          i.stub(:remote_image?).and_return(false)
          File.stub(:exist?).and_return false
          i.sized_url(100, :longest_side)
          expect(i.was_sized).to be_false
        end
      end
    end
  end

  describe '#sized_filename' do
    let(:image) { Image.new }

    before { image.stub(:extension).and_return('jpg') }

    it 'contains the method, size and extension' do
      expect(image.sized_filename(100, :longest_side)).to eq 'longest_side_100.jpg'
    end

    it 'handles size as an [x,y] array' do
      expect(image.sized_filename([50, 100], :longest_side)).to eq 'longest_side_50x100.jpg'
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
