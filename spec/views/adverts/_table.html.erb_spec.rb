require "rails_helper"

RSpec.describe "adverts/_table.html.erb", type: :view do
  it "shows the count of clicks" do
    directory_advert = FactoryBot.create(:directory_advert)
    directory_advert.clicks << TrackedAction.new(action_type: :click)
    render(partial: "table", locals: {adverts: [directory_advert], title: "title"})
    expect(Capybara.string(rendered).find("td.clicks")).to have_content("1")
  end

  it "shows button to remove a currently advertised advert from window" do
    allow(view).to receive(:admin?).and_return(false)
    directory_advert = FactoryBot.build_stubbed(:directory_advert)
    window_advert = FactoryBot.build(
      :advert,
      window_spot: true, starts_at: Date.current, expires_at: Date.current
    )
    allow(directory_advert)
      .to receive(:current_advert)
      .and_return(window_advert)
    render(
      partial: "table", locals: {adverts: [directory_advert], title: "title"}
    )
    assert_select(
      "form[action='#{remove_from_window_property_path(directory_advert)}']"
    )
  end
end
