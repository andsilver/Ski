require "rails_helper"

describe InterhomePlaceResort do
  it { should validate_presence_of(:interhome_place_code) }

  describe "#name" do
    let(:code) { "AD_1_1450" }

    it "looks up an Interhome place by code" do
      expect(InterhomePlace).to receive(:find_by).with(code: code)
      ipr = InterhomePlaceResort.new(interhome_place_code: code)
      ipr.name
    end

    context "when it references a valid Interhome place code" do
      let(:full_name) { "Andorra > Andorra > Arinsal" }

      it "returns the full name of the Interhome place" do
        allow(InterhomePlace).to receive(:find_by).and_return(InterhomePlace.new(full_name: full_name))
        ipr = InterhomePlaceResort.new(interhome_place_code: code)
        expect(ipr.name).to eq full_name
      end
    end

    context "when it doesn not reference a valid Interhome place code" do
      it "returns the place code followed by (missing)" do
        allow(InterhomePlace).to receive(:find_by).and_return(nil)
        ipr = InterhomePlaceResort.new(interhome_place_code: code)
        expect(ipr.name).to eq "#{code} (missing)"
      end
    end
  end
end
