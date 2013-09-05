require 'spec_helper'

describe 'regions/how_to_get_there' do
  fixtures :countries, :regions

  before do
    rhone_alpes = regions(:rhone_alpes)
    assign(:region, rhone_alpes)
  end

  it 'displays the page content' do
    assign(:page_content, 'Take the first left')
    render
    expect(rendered).to have_content('Take the first left')
  end
end
