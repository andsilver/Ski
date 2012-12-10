Given /^there exists a category named "(.*?)"$/ do |name|
  Category.create!(name: name)
end
