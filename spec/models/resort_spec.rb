require 'spec_helper'

describe Resort do
  it "has an SEO-friendly to_param" do
    resort = Resort.new
    resort.name = "Italian Alps"
    resort.id = 2
    resort.to_param.should == "2-italian-alps"
  end
end
