require 'rails_helper'

feature "Holiday type brochures" do
  fixtures :websites

  let(:france) { FactoryGirl.create(:country) }
  let(:ski_holidays) { FactoryGirl.create(:holiday_type) }

  scenario "Holiday type page lists child resorts" do
    france.holiday_type_brochures.build(holiday_type_id: ski_holidays.id)
    france.save

    FactoryGirl.create(:resort, name: 'Flaine', country: france)
    morzine = FactoryGirl.create(:resort, name: 'Morzine', country: france)
    morzine.holiday_type_brochures.build(holiday_type_id: ski_holidays.id)
    morzine.save

    visit holiday_type_brochure_path('countries', france, ski_holidays.slug)
    expect(page.find('#links-and-search')).to have_content('Morzine')
    expect(page.find('#links-and-search')).not_to have_content('Flaine')
  end
end
