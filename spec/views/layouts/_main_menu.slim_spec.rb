require 'rails_helper'

describe 'layouts/_main_menu', type: :view do
  let(:holiday_type) { FactoryBot.create(:holiday_type) }

  before { allow(HolidayType).to receive(:on_menu).and_return([holiday_type]) }

  it 'display main menu for holiday types' do
    render
    expect(rendered).to have_selector('li.main-menu-item')
  end

  context 'when click on menu item' do
    it 'shows the menu link items' do
      render
      menu_item = Capybara.string(rendered).find(:css, '.main-menu-item')
      # byebug
      click_on(menu_item)
      expect(rendered).to have_selector('ul.main-menu-item-links', visible: true)
    end
  end
end
