require 'spec_helper'

describe DirectoryAdvertsController do
  let(:current_user) { mock_model(User).as_null_object }

  before do
    session[:user] = 1
    User.stub(:find_by_id).and_return(current_user)
  end

  describe "GET my" do
    it "finds directory adverts belonging to the current user" do
      current_user.should_receive(:directory_adverts)
      get "my"
    end
  end

  describe "GET new" do
    it "instantiates a new directory advert" do
      DirectoryAdvert.should_receive(:new)
      get "new"
    end

    it "assigns @directory_advert" do
      get "new"
      assigns(:directory_advert).should_not be_nil
    end
  end

  describe "POST create" do
    let(:directory_advert) { mock_model(DirectoryAdvert).as_null_object }

    before do
      DirectoryAdvert.stub(:new).and_return(directory_advert)
    end

    it "instantiates a new directory advert" do
      DirectoryAdvert.should_receive(:new).with("category_id" => "1").and_return(directory_advert)
      post "create", :directory_advert => { :category_id => "1" }
    end

    it "associates the advert with the current user" do
      directory_advert.should_receive(:user_id=).with(current_user.id)
      post "create", :directory_advert => { :category_id => "1" }
    end

    context "when the directory advert saves successfully" do
      before do
        directory_advert.stub(:save).and_return(true)
      end

      it "sets a flash[:notice] message" do
        post "create", :directory_advert => { :category_id => "1" }
        flash[:notice].should eq("Your directory advert was successfully created.")
      end

      it "redirects to my directory adverts" do
        post "create", :directory_advert => { :category_id => "1" }
        response.should redirect_to(:action => "my")
      end
    end

    context "when the directory advert fails to save" do
      before do
        directory_advert.stub(:save).and_return(false)
      end

      it "assigns @directory_advert" do
        post :create
        assigns[:directory_advert].should eq(directory_advert)
      end

      it "renders the new template" do
        post :create
        response.should render_template("new")
      end
    end
  end
end
