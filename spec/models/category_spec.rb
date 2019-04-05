require "rails_helper"

describe Category do
  it "has an SEO-friendly to_param using i18n" do
    category = Category.new
    category.name = "category_names.internet_cafe"
    category.id = 1
    expect(category.to_param).to eq "1-internet-cafes"
  end

  it "prevents deletion with associated directory adverts" do
    category = FactoryBot.create(:category)
    da = FactoryBot.create(:directory_advert, category_id: category.id)
    da.save!
    expect { category.destroy }.to raise_error(ActiveRecord::DeleteRestrictionError)
  end
end
