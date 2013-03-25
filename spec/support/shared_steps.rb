def add_banner_advert_to_basket(options = {})
  options = {
    resorts: ['France > Chamonix']
  }.merge(options)

  visit '/directory_adverts/new'
  choose 'Banner advert with free directory advert'
  options[:resorts].each { |resort| select resort, from: 'Resorts' }
  select 'Bars', from: 'Category'
  fill_in 'Business name', with: 'My business'
  fill_in 'Business address', with: 'An address'
  fill_in 'Strapline', with: 'Strapline'
  attach_file 'Directory image', 'test-files/banner-image.png'
  attach_file 'Banner image', 'test-files/banner-image.png'
  click_button 'Save'
end

def sign_in_as_emily_evans
  visit '/sign_in'
  fill_in 'Email', with: 'emily@mychaletfinder.com'
  fill_in 'Password', with: 'secret'
  click_button 'Sign In'
end
