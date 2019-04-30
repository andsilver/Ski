require "rails_helper"

RSpec.describe "Holiday type brochures", type: :request do
  before do
    FactoryBot.create(:website)
  end

  it "lists regions matching the holiday type" do
    italy = FactoryBot.create(:country, slug: "italy")

    ski = FactoryBot.create(:holiday_type, slug: "ski-holidays")
    alta_badia = FactoryBot.create(:region, name: "Alta Badia", country: italy)
    HolidayTypeBrochure.create!(holiday_type: ski, brochurable: alta_badia)

    lakes = FactoryBot.create(:holiday_type, slug: "lakes-and-mountains")
    lake_como = FactoryBot.create(:region, name: "Lake Como", country: italy)
    HolidayTypeBrochure.create!(holiday_type: lakes, brochurable: lake_como)

    HolidayTypeBrochure.create!(holiday_type: ski, brochurable: italy)

    FactoryBot.create(
      :page,
      path: "/countries/italy/holidays/ski-holidays/ski-areas",
      content: "{{ featured_ski_regions }} {{ ski_regions }}"
    )

    get "/countries/italy/holidays/ski-holidays/ski-areas"

    expect(response.status).to eq 200

    expect(response.body).to include "Alta Badia"
    expect(response.body).not_to include "Lake Como"
  end

  it "lists resorts matching the holiday type" do
    italy = FactoryBot.create(:country, slug: "italy")

    ski = FactoryBot.create(:holiday_type, slug: "ski-holidays")
    colfosco = FactoryBot.create(:resort, name: "Colfosco", country: italy)
    HolidayTypeBrochure.create!(holiday_type: ski, brochurable: colfosco)

    lakes = FactoryBot.create(:holiday_type, slug: "lakes-and-mountains")
    lecco = FactoryBot.create(:resort, name: "Lecco", country: italy)
    HolidayTypeBrochure.create!(holiday_type: lakes, brochurable: lecco)

    HolidayTypeBrochure.create!(holiday_type: ski, brochurable: italy)

    FactoryBot.create(
      :page,
      path: "/countries/italy/holidays/ski-holidays/ski-areas",
      content: "{{ ski_resorts }}"
    )

    get "/countries/italy/holidays/ski-holidays/ski-areas"

    expect(response.status).to eq 200

    expect(response.body).to include "Colfosco"
    expect(response.body).not_to include "Lecco"
  end
end
