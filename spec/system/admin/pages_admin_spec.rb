# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Pages admin", type: :system do
  fixtures :roles, :users, :websites

  before do
    sign_in_as_admin
  end

  scenario "Add a new page" do
    the_page = Page.new(
      path: SecureRandom.hex,
      title: "Title",
      header_snippet_name: "Sponsorship"
    )

    visit pages_path
    click_link "New Page"

    fill_in "Path", with: the_page.path
    fill_in "Title", with: the_page.title
    fill_in "Header snippet name", with: the_page.header_snippet_name
    click_button "Create"

    expect(Page.find_by(
      path: the_page.path,
      title: the_page.title,
      header_snippet_name: the_page.header_snippet_name
    )).to be
  end
end
