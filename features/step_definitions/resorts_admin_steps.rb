Then /^I should see a table of resorts$/ do
  within("table") do
    page.should have_content("St Anton")
    page.should have_content("Chamonix")
    page.should have_content("Italian Alps")
    page.should have_content("Davos")
  end
end

Then /^I should see resorts that are not visible to the public$/ do
  within("table") do
    page.should have_content("An Invisible Resort")
  end
end

When /^Chamonix has meta pages for intro, guide, gallery and piste map$/ do
  create_meta_page(resort_path(resorts(:chamonix)))
  create_meta_page(resort_path(resorts(:chamonix)) + "/resort-guide")
  create_meta_page(resort_path(resorts(:chamonix)) + "/gallery")
  create_meta_page(resort_path(resorts(:chamonix)) + "/piste_map")
end

Then /^I should see links to edit intro, guide, gallery and piste map meta$/ do
  within("#additional-pages") do
    page.should have_content("Edit intro meta")
    page.should have_content("Edit guide meta")
    page.should have_content("Edit gallery meta")
    page.should have_content("Edit piste map meta")
  end
end

def create_meta_page(path)
  Page.create!(path: path, title: path)
end
