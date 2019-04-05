require "rails_helper"

RSpec.describe "images/_form.html.erb", type: :view do
  let(:user) { FactoryBot.create(:user) }

  before do
    assign(:image, Image.new)
    assign(:object, object)
    assign(:current_user, user)
  end

  context "with a Property object" do
    let(:object) { FactoryBot.create(:property) }

    context "with no images uploaded" do
      it "states no images have been uploaded" do
        render
        expect(rendered).to have_content t("images.form.none_uploaded")
      end
    end
  end
end
