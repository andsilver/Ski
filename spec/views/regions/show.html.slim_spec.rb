require 'rails_helper'

describe 'regions/show.html.slim' do
  before do
    assign(:featured_properties, [])
  end

  it 'shows the quick search form' do
    assign(:region, FactoryGirl.create(:region))
    render
    expect(view.content_for(:links_and_search)).to have_content(t('home.quick_search.heading'))
  end
end
