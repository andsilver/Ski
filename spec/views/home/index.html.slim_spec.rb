require "rails_helper"

describe "home/index.html.slim" do
  it "renders {{featured_properties}}" do
    assign(:w, FactoryBot.build(:website, home_content: "{{featured_properties}}"))
    property = FactoryBot.build(:property)
    assign(:featured_properties, [property])
    render
    expect(rendered).to have_selector("[title='#{property.name}']")
  end
end
