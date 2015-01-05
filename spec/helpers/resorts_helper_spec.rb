require 'rails_helper'

RSpec.describe ResortsHelper, type: :helper do
  describe '#images_in_directory' do
    it 'returns filenames that could be images' do
      allow(Dir).to receive(:entries).and_return(['.', '..', 'image.jpg', 'ignore'])
      expect(images_in_directory('some/dir')).to eq ['image.jpg']
    end

    it 'returns sorted filenames' do
      allow(Dir).to receive(:entries).and_return(['z.jpg', 'a.jpg'])
      expect(images_in_directory('some/dir')).to eq ['a.jpg', 'z.jpg']
    end

    it 'returns empty array when directory missing' do
      expect(images_in_directory('nonexistent')).to eq []
    end
  end
end
