require 'spec_helper'

describe Resort do
  # ActiveRecord
  it { should have_many(:interhome_place_resorts) }
  it { should respond_to(:summer_only?) }

  it "has an SEO-friendly to_param" do
    resort = Resort.new
    resort.name = "Italian Alps"
    resort.id = 2
    expect(resort.to_param).to eq "2-italian-alps"
  end

  describe '#to_s' do
    it 'returns its name' do
      expect(Resort.new(name: 'Chamonix').to_s).to eq 'Chamonix'
    end
  end

  describe '#has_page?' do
    it 'returns true if the page exists' do
      r = Resort.new
      r.stub(:page).and_return(Page.new)
      expect(r.has_page?('a-page')).to be_true
    end

    it 'returns false if the page does not exist' do
      r = Resort.new
      r.stub(:page).and_return(nil)
      expect(r.has_page?('a-page')).to be_false
    end
  end

  describe '#page' do
    it 'finds the page with the corresponding path' do
      r = Resort.new
      r.should_receive(:page_path).with('a-page').and_return('/path/to/a-page')
      Page.should_receive(:find_by_path).with('/path/to/a-page')
      r.page('a-page')
    end
  end

  describe '#page_path' do
    it 'returns the corresponding page path' do
      r = Resort.new(name: 'A Resort')
      expect(r.page_path('a-page')).to eq '/resorts/-a-resort/a-page'
    end
  end

  describe '#handle_name_change' do
    it 'updates the paths of affected pages' do
      require 'securerandom'
      name_pre = SecureRandom.hex
      name_post = SecureRandom.hex
      r = FactoryGirl.create(:resort, name: name_pre)
      r.create_page('summer-holidays')
      r.name = name_post
      r.save
      expect(r.page('summer-holidays').path).to match(name_post)
    end
  end
end
