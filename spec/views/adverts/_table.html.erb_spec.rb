require 'rails_helper'

describe 'adverts/_table.html.erb' do
  it 'shows the count of clicks' do
    directory_advert = FactoryGirl.create(:directory_advert)
    directory_advert.clicks << TrackedAction.new(action_type: :click)
    render(partial: 'table', locals: {adverts: [directory_advert], title: 'title'})
    expect(Capybara.string(rendered).find('td.clicks')).to have_content('1')
  end
end
