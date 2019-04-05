module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      "/"

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    when /the edit resort page for Chamonix/
      edit_resort_path(resorts(:chamonix))

    when /the new Chamonix category page/
      new_resort_category_path(resorts(:chamonix))

    when /the Chamonix directory page/
      directory_resort_path(resorts(:chamonix))

    when /the Chamonix new developments page/
      resort_property_new_developments_path(resorts(:chamonix))

    when /the Chamonix resort info page/
      resort_path(resorts(:chamonix))

    when /the Chamonix Properties for Rent page/
      resort_property_rent_path(resorts(:chamonix))

    when /the Chamonix Properties for Sale page/
      resort_property_sale_path(resorts(:chamonix))

    when /the Italian Alps Properties for Rent page/
      resort_property_rent_path(resorts(:italian_alps))

    when /the Alpen Lounge page/
      property_path(properties(:alpen_lounge))

    when /the Website CMS page/
      edit_website_path(websites(:website_settings))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        send(path_components.push("path").join("_").to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
