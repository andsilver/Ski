require "rails_helper"

RSpec.describe "properties/new.html.erb", type: :view do
  let(:property) { Property.new }
  let(:user) { FactoryBot.create(:user) }

  before do
    allow(view).to receive(:current_user).and_return(user)
    assign(:property, property)
    allow(view).to receive(:admin?).and_return(admin)
  end

  context "when not admin" do
    let(:admin) { false }

    it "renders" do
      render
    end

    it "sets title" do
      render
      expect(view.content_for(:title)).not_to be_blank
    end
  end

  context "when admin" do
    let(:admin) { true }

    it "renders" do
      render
    end
  end
end
