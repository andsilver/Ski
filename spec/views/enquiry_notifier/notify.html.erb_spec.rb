require "rails_helper"

RSpec.describe "enquiry_notifier/notify.html.erb", type: :view do
  let(:property) { FactoryBot.create(:property) }
  let(:enquiry) { FactoryBot.create(:enquiry) }

  before do
    assign(:property, property)
    assign(:enquiry, enquiry)
  end

  it "includes the resort" do
    render
    expect(rendered).to have_content property.resort
  end
end
