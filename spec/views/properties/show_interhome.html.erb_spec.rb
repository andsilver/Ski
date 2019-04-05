require "rails_helper"

RSpec.describe "properties/show_interhome.html.erb", type: :view do
  let(:accommodation) { FactoryBot.create(:interhome_accommodation) }
  let(:property) { FactoryBot.create(:property, interhome_accommodation: accommodation).decorate }

  before do
    assign(:accommodation, accommodation)
    assign(:property, property)
  end

  it "displays an ABTA logo for increased customer confidence" do
    render
    expect(rendered).to have_selector ".abta img"
  end
end
