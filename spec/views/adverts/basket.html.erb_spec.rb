require "rails_helper"

describe "adverts/basket" do
  fixtures :countries, :users, :currencies

  before { assign(:current_user, users(:alice)) }

  context "with items in the basket" do
    before do
      line_1 = BasketLine.new
      line_1.price = 10
      lines = [line_1]
      assign(:lines, lines)
      assign(:subtotal, 10)
      assign(:tax_amount, 2)
      assign(:total, 12)
    end

    it "shows an Empty Basket button" do
      render
      expect(rendered).to have_selector("input[name=empty_basket]")
    end
  end

  context "with an empty basket" do
    before { assign(:lines, []) }

    it "says basket is empty" do
      render
      expect(rendered).to have_content(t("adverts.basket.empty"))
    end
  end
end
