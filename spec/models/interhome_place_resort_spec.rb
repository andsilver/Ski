require 'spec_helper'

describe InterhomePlaceResort do
  it { should validate_presence_of(:interhome_place_code) }

  describe '#name' do
    let(:code) { 'AD_1_1450' }

    it 'looks up an Interhome place by code' do
      InterhomePlace.should_receive(:find_by_code).with(code)
      ipr = InterhomePlaceResort.new(:interhome_place_code => code)
      ipr.name
    end

    context 'when it references a valid Interhome place code' do
      let(:full_name) { 'Andorra > Andorra > Arinsal' }

      it 'returns the full name of the Interhome place' do
        InterhomePlace.stub(:find_by_code).and_return(InterhomePlace.new(:full_name => full_name))
        ipr = InterhomePlaceResort.new(:interhome_place_code => code)
        ipr.name.should == full_name
      end
    end

    context 'when it doesn not reference a valid Interhome place code' do
      it 'returns the place code followed by (missing)' do
        InterhomePlace.stub(:find_by_code).and_return(nil)
        ipr = InterhomePlaceResort.new(:interhome_place_code => code)
        ipr.name.should == "#{code} (missing)"
      end
    end
  end
end
