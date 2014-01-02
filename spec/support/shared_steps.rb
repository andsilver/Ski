def add_banner_advert_to_basket(options = {})
  options = {
    resorts: ['France > Chamonix'],
    strapline: 'Strapline'
  }.merge(options)

  visit '/directory_adverts/new'
  choose 'Banner advert with free directory advert'
  options[:resorts].each { |resort| select resort, from: 'Resorts' }
  select 'Bars', from: 'Category'
  fill_in 'Business name', with: 'My business'
  fill_in 'Business address', with: 'An address'
  fill_in 'Strapline', with: options[:strapline]
  attach_file 'Directory image', 'test-files/banner-image.png'
  attach_file 'Banner image', 'test-files/banner-image.png'
  click_button 'Save'
end

def sign_in_as_admin
  sign_in_with('tony@mychaletfinder.com', 'secret')
end

def sign_in_as_emily_evans
  sign_in_with('emily@mychaletfinder.com', 'secret')
end

def sign_in_as_a_property_developer
  sign_in_with('bob@mychaletfinder.com', 'secret')
end

def sign_in_as_a_property_owner
  sign_in_with('dave@mychaletfinder.com', 'secret')
end

def sign_in_with(email, password)
  visit '/sign_in'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Sign In'
end

def signed_in
  controller.stub(:current_user).and_return(FactoryGirl.create(:user))
end

def signed_in_as_admin
  controller.stub(:admin?).and_return(true)
end
