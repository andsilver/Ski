require "rails_helper"

describe "admin/holiday_types/_form" do
  context "with errors" do
    before do
      holiday_type = HolidayType.new
      expect(holiday_type.save).to be_falsey
      assign(:holiday_type, holiday_type)
    end

    it "displays errors" do
      render
      expect(rendered).to have_selector(".alert-error")
    end
  end
end
