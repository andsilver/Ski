require 'spec_helper'

describe Resort do
  # ActiveRecord
  it { should have_many(:interhome_place_resorts) }
  it { should respond_to(:summer_only?) }

  it "has an SEO-friendly to_param" do
    resort = Resort.new
    resort.name = "Italian Alps"
    resort.id = 2
    resort.to_param.should == "2-italian-alps"
  end

  describe '#to_s' do
    it 'returns its name' do
      Resort.new(name: 'Chamonix').to_s.should == 'Chamonix'
    end
  end

  describe '#has_page?' do
    it 'returns true if the page exists' do
      r = Resort.new
      r.stub(:page).and_return(Page.new)
      r.has_page?('a-page').should be_true
    end

    it 'returns false if the page does not exist' do
      r = Resort.new
      r.stub(:page).and_return(nil)
      r.has_page?('a-page').should be_false
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
      r = Resort.new
      r.stub(:to_param).and_return('resort-param')
      r.page_path('a-page').should == '/resorts/resort-param/a-page'
    end
  end
end
