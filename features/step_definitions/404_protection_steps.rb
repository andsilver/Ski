When /^I visit a country page without visible resorts$/ do
  visit country_path(countries(:a_country_without_visible_resorts))
end

When /^I visit a country page with visible resorts$/ do
  visit country_path(countries(:france))
end

When /^I visit an invisible resort page$/ do
  visit resort_path(resorts(:an_invisible_resort))
end

When /^I visit a visible resort page$/ do
  visit resort_path(resorts(:chamonix))
end
