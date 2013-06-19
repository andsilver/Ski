require 'spec_helper'

feature 'Late Availability' do
  fixtures :websites

  scenario 'Visit the page' do
    visit '/late-availability'
    expect(page).to have_content 'Late Availability'
  end

  scenario 'Featured late availability properties' do
    setup_late_availability_properties(8)
    visit '/late-availability'
    expect(page).to have_content 'Featured Last Minute Properties'
    8.times {|x| expect(page).to have_content "Sleeps #{x}"}
  end

  def setup_late_availability_properties(how_many)
    how_many.times do |x|
      create_property(late_availability: true, sleeping_capacity: x)
    end
  end

  def create_property(attributes)
    @country ||= FactoryGirl.create(:country)
    @resort ||= FactoryGirl.create(:resort, country: @country)
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
