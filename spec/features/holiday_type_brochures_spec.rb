require 'spec_helper'

feature "Holiday type brochures" do
  fixtures :countries, :holiday_types, :websites

  scenario "Holiday type page lists child resorts" do
    countries(:france).holiday_type_brochures.build(holiday_type_id: holiday_types(:ski_holidays).id)
    countries(:france).save

    FactoryGirl.create(:resort, name: 'Flaine', country: countries(:france))
    morzine = FactoryGirl.create(:resort, name: 'Morzine', country: countries(:france))
    morzine.holiday_type_brochures.build(holiday_type_id: holiday_types(:ski_holidays).id)
    morzine.save

    visit holiday_type_brochure_path('countries', countries(:france), holiday_types(:ski_holidays).slug)
    expect(page.find('#links-and-search')).to have_content('Morzine')
    expect(page.find('#links-and-search')).not_to have_content('Flaine')
  end
end
