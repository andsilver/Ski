require "rails_helper"

RSpec.describe "properties/_form.html.slim", type: :view do
  fixtures :roles, :users

  context "with a property developer" do
    before do
      allow(view).to receive(:current_user).and_return(users(:bob)) # a property developer
      allow(view).to receive(:admin?).and_return(false)
    end

    it "renders listing_type as a hidden field" do
      assign(:property, Property.new)
      render
      expect(rendered).to have_selector(
        'input[type="hidden"]#property_listing_type', visible: false
      )
    end

    context "with a property for sale" do
      before do
        assign(:property, Property.new(listing_type: Property::LISTING_TYPE_FOR_SALE))
        render
      end

      it "shows a new development checkbox" do
        expect(rendered).to have_selector("input#property_new_development")
      end
    end

    context "with a property for rent" do
      before do
        assign(:property, Property.new(listing_type: Property::LISTING_TYPE_FOR_RENT))
        render
      end

      it "does not show a new development checkbox" do
        expect(rendered).not_to have_selector("input#property_new_development")
      end
    end
  end

  context "when admin" do
    before do
      allow(view).to receive(:admin?).and_return(true)
      allow(view).to receive(:current_user).and_return(FactoryBot.build(:admin_user))
      assign(:property, Property.new)
      render
    end

    subject { rendered }

    it { should have_selector("select#property_listing_type") }
  end
end
