# frozen_string_literal: true

require "rails_helper"

RSpec.describe "View New Development", type: :system do
  fixtures :websites

  let(:new_development) do
    FactoryBot.create(
      :property,
      listing_type: Property::LISTING_TYPE_FOR_SALE, new_development: true
    )
  end

  scenario "Viewing a new development shows a breadcrumb for new developments" do
    visit property_path(new_development)
    expect(page.find(".breadcrumb li + li a"))
      .to have_content(I18n.t("new_developments"))
  end
end
