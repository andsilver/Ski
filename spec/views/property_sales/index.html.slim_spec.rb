# frozen_string_literal: true

require "rails_helper"

RSpec.describe "property_sales/index.html.slim", type: :view do
  it "renders {{property_sales}}" do
    assign(:w, FactoryBot.build(:website, home_content: "{{property_sales}}"))
    render
    expect(view.content_for(:search))
      .to have_content("Find properties here")
  end
end
