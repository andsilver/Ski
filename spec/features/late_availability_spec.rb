require 'spec_helper'

feature 'Late Availability' do
  before { setup_website }

  scenario 'Visit the page' do
    visit '/late-availability'
    page.should have_content 'Late Availability'
  end

  scenario 'Featured late availability properties' do
    setup_late_availability_properties(9)
    visit '/late-availability'
    save_and_open_page
    page.should have_content 'Featured Properties'
    9.times {|x| page.should have_content "Featured property #{x}"}
  end

  def setup_website
    Website.create!
  end

  def setup_late_availability_properties(how_many)
    how_many.times do |x|
      create_property(late_availability: true, name: "Featured property #{x}")
    end
  end

  def create_property(attributes)
    @country ||= Country.create!(name: 'Country')
    @resort ||= Resort.create!(name: 'Resort', country_id: @country.id)
    @currency ||= Currency.create!(name: 'sterling', code: 'gbp', in_euros: 1)

    attributes = {
      resort: @resort,
      address: 'address',
      name: 'property',
      currency: @currency,
      user_id: 1
    }.merge(attributes)

    Property.create!(attributes)
  end
end
