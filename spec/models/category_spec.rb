require 'spec_helper'

describe Category do
  it "has an SEO-friendly to_param using i18n" do
    category = Category.new
    category.name = "internet_cafe"
    category.id = 1
    category.to_param.should == "1-internet-cafes"
  end
end
