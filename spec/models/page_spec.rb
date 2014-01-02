require 'spec_helper'

describe Page do
  describe '#meta_ok?' do
    it 'returns true if description present and title <= 51 chars' do
      page = Page.new(description: 'Description', title: 'Short')
      expect(page.meta_ok?).to be_true
    end

    it 'returns false if description is blank' do
      page = Page.new(description: '', title: 'Short')
      expect(page.meta_ok?).to be_false
    end

    it 'returns false if title > 51 chars' do
      page = Page.new(description: 'Description', title: 'x' * 52)
      expect(page.meta_ok?).to be_false
    end
  end
end
