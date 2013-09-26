require 'spec_helper'

describe 'home/index.html.slim' do
  it 'renders {{featured_properties}}' do
    assign(:w, FactoryGirl.build(:website, home_content: '{{featured_properties}}'))
    property = FactoryGirl.build(:property)
    assign(:featured_properties, [property])
    render
    expect(rendered).to have_selector("[title='#{property.name}']")
  end
end
