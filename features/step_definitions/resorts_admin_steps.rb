Then /^I should see a table of resorts$/ do
  within('table') do
    page.should have_content('St Anton')
    page.should have_content('Chamonix')
    page.should have_content('Italian Alps')
    page.should have_content('Davos')
  end
end

Then /^I should see resorts that are not visible to the public$/ do
  within('table') do
    page.should have_content('An Invisible Resort')
  end
end
