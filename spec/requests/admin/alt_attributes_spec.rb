require "rails_helper"

RSpec.describe "Alt attributes admin", type: :request do
  before do
    FactoryBot.create(:website)
    allow_any_instance_of(ApplicationController)
      .to receive(:admin?)
      .and_return(true)
  end

  describe "GET /admin/alt_attributes" do
    it "lists alt attributes" do
      aa = FactoryBot.create(:alt_attribute)
      get admin_alt_attributes_path
      assert_select "td", content: aa.path
    end
  end

  describe "GET /admin/alt_attributes/new" do
    it "shows a form" do
      get new_admin_alt_attribute_path
      assert_select "form[action='#{admin_alt_attributes_path}']"
    end
  end

  describe "POST /admin/alt_attributes" do
    context "with valid params" do
      before do
        post(
          admin_alt_attributes_path,
          params: {
            alt_attribute: {
              alt_text: "alt",
              path: "path",
            },
          }
        )
      end

      it "creates a new alt attribute" do
        aa = AltAttribute.last
        expect(aa).to be
        expect(aa.alt_text).to eq "alt"
        expect(aa.path).to eq "path"
      end

      it "redirects to the index" do
        expect(response).to redirect_to(admin_alt_attributes_path)
      end

      it "sets a flash notice" do
        expect(flash[:notice]).to eq I18n.t("notices.created")
      end
    end

    context "with invalid params" do
      before do
        FactoryBot.create(:alt_attribute, path: "path")
        post(
          admin_alt_attributes_path,
          params: {
            alt_attribute: {
              alt_text: "alt",
              path: "path",
            },
          }
        )
      end

      it "shows the form again" do
        assert_select "form[action='#{admin_alt_attributes_path}']" do
          assert_select "input[name='alt_attribute[path]'][value='path']"
        end
      end
    end
  end

  describe "GET /admin/alt_attributes/:id/edit" do
    it "shows a form to edit the alt attribute" do
      alt_attribute = FactoryBot.create(:alt_attribute)
      get edit_admin_alt_attribute_path(alt_attribute)
      assert_select "form[action='#{admin_alt_attribute_path(alt_attribute)}']"
    end
  end

  describe "PATCH /admin/alt_attributes/:id" do
    context "with valid params" do
      let(:alt_attribute) { FactoryBot.create(:alt_attribute) }
      before do
        patch(
          admin_alt_attribute_path(alt_attribute),
          params: {
            alt_attribute: {
              alt_text: "alt",
              path: "path",
            },
          }
        )
      end

      it "updates the alt attribute" do
        alt_attribute.reload
        expect(alt_attribute.alt_text).to eq "alt"
        expect(alt_attribute.path).to eq "path"
      end

      it "redirects to the index" do
        expect(response).to redirect_to(admin_alt_attributes_path)
      end

      it "sets a flash notice" do
        expect(flash[:notice]).to eq I18n.t("notices.saved")
      end
    end

    context "with invalid params" do
      let(:aa) { FactoryBot.create(:alt_attribute) }
      before do
        FactoryBot.create(:alt_attribute, path: "exists")
        patch(
          admin_alt_attribute_path(aa),
          params: {alt_attribute: {alt_text: "alt", path: "exists"}}
        )
      end

      it "shows the form again" do
        assert_select "form[action='#{admin_alt_attribute_path(aa)}']" do
          assert_select "input[name='alt_attribute[path]'][value='exists']"
        end
      end
    end
  end

  describe "DELETE /admin/alt_attributes/:id" do
    let(:alt_attribute) { FactoryBot.create(:alt_attribute) }
    before { delete admin_alt_attribute_path(alt_attribute) }

    it "deletes the alt attribute" do
      expect(AltAttribute.exists?(alt_attribute.id)).to be_falsey
    end

    it "redirects to the index" do
      expect(response).to redirect_to(admin_alt_attributes_path)
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to eq I18n.t("notices.deleted")
    end
  end
end
