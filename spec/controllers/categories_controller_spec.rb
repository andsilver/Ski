require 'spec_helper'

describe CategoriesController do
  let(:website) { mock_model(Website).as_null_object }
  let(:category) { mock_model(Category).as_null_object }
  let(:resort) { mock_model(Resort).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    Category.stub(:new).and_return(category)
    Resort.stub(:find).and_return(resort)
    controller.stub(:admin?).and_return(true)
  end

  describe "GET new" do
    it "instantiates a new category" do
      Category.should_receive(:new)
      get :new
    end

    it "assigns @category" do
      get :new
      assigns[:category].should equal(category)
    end
  end

  describe "POST create" do
    let(:params) { { :resort_id => 1, :category => { "name" => "Restaurants", "resort_id" => "1" }} }

    it "instantiates a new category with the given params" do
      Category.should_receive(:new).with(params[:category])
      post :create, params
    end

    context "when the category saves successfully" do
      before do
        category.stub(:save).and_return(true)
      end

      it "sets a flash[:notice] message" do
        post :create, params
        flash[:notice].should eq("Created.")
      end

      it "redirects to the categories page" do
        post :create, params
        response.should redirect_to(categories_path)
      end
    end

    context "when the category fails to save" do
      before do
        category.stub(:save).and_return(false)
      end

      it "assigns @category" do
        post :create, params
        assigns[:category].should eq(category)
      end

      it "renders the new template" do
        post :create, params
        response.should render_template("new")
      end
    end
  end

  describe "GET show" do
  end
end
