require "rails_helper"

describe "layouts/_main_menu" do
  let(:holiday_type) { FactoryBot.create(:holiday_type) }

  before do
    allow(HolidayType).to receive(:on_menu).and_return([holiday_type])
  end

  it "display main menu for holiday types" do
    render
    expect(rendered).to have_selector("li.main-menu-item")
  end
end
