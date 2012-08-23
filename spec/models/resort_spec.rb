require 'spec_helper'

describe Resort do
  # ActiveRecord
  it { should have_many(:interhome_place_resorts) }

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
end
