require 'spec_helper'

describe Category do
  it "has an SEO-friendly to_param" do
    category = Category.new
    category.name = "Bars & Restaurants"
    category.id = 1
    category.to_param.should == "1-bars-restaurants"
  end
end
