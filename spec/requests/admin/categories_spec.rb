require "rails_helper"

RSpec.describe "Categories admin", type: :request do
  before do
    FactoryBot.create(:website)
    allow_any_instance_of(ApplicationController)
      .to receive(:admin?)
      .and_return(true)
  end

  describe "GET /admin/categories" do
    it "lists categories" do
      category = FactoryBot.create(:category)
      get admin_categories_path
      assert_select "td", content: category.name
    end
  end

  describe "GET /admin/categories/new" do
    it "shows a form" do
      get new_admin_category_path
      assert_select "form[action='#{admin_categories_path}']"
    end
  end

  describe "POST /admin/categories" do
    context "with valid params" do
      before do
        post(
          admin_categories_path,
          params: {category: {name: "Restaurants"}}
        )
      end

      it "creates a new category" do
        category = Category.last
        expect(category).to be
        expect(category.name).to eq "Restaurants"
      end

      it "redirects to the categories index" do
        expect(response).to redirect_to(admin_categories_path)
      end

      it "sets a flash notice" do
        expect(flash[:notice]).to eq I18n.t("notices.created")
      end
    end

    context "with invalid params" do
      before do
        FactoryBot.create(:category, name: "Taxi")
        post admin_categories_path, params: {category: {name: "Taxi"}}
      end

      it "shows the form again" do
        assert_select "form[action='#{admin_categories_path}']" do
          assert_select "input[name='category[name]'][value='Taxi']"
        end
      end
    end
  end

  describe "GET /admin/categories/:id/edit" do
    it "shows a form to edit the category" do
      category = FactoryBot.create(:category)
      get edit_admin_category_path(category)
      assert_select "form[action='#{admin_category_path(category)}']"
    end
  end

  describe "PATCH /admin/categories/:id" do
    context "with valid params" do
      let(:category) { FactoryBot.create(:category) }
      before do
        patch(
          admin_category_path(category),
          params: {category: {name: "Restaurants"}}
        )
      end

      it "updates the category" do
        category.reload
        expect(category.name).to eq "Restaurants"
      end

      it "redirects to the categories index" do
        expect(response).to redirect_to(admin_categories_path)
      end

      it "sets a flash notice" do
        expect(flash[:notice]).to eq I18n.t("notices.saved")
      end
    end

    context "with invalid params" do
      let(:category) { FactoryBot.create(:category) }
      before do
        FactoryBot.create(:category, name: "Taxi")
        patch(
          admin_category_path(category), params: {category: {name: "Taxi"}}
        )
      end

      it "shows the form again" do
        category.name = "Taxi" # URL generation depends on name
        assert_select "form[action='#{admin_category_path(category)}']" do
          assert_select "input[name='category[name]'][value='Taxi']"
        end
      end
    end
  end

  describe "DELETE /admin/categories/:id" do
    let(:category) { FactoryBot.create(:category) }
    before { delete admin_category_path(category) }

    it "deletes the category" do
      expect(Category.exists?(category.id)).to be_falsey
    end

    it "redirects to the categories index" do
      expect(response).to redirect_to(admin_categories_path)
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to eq I18n.t("notices.deleted")
    end
  end
end
