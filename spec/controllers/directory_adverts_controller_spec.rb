require 'spec_helper'

describe DirectoryAdvertsController do
  let(:website) { mock_model(Website).as_null_object }
  let(:current_user) { mock_model(User).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    session[:user] = 1
    User.stub(:find_by_id).and_return(current_user)
  end

  describe "GET index" do
    before do
      controller.stub(:admin?).and_return(true)
    end

    it "finds all directory adverts" do
      DirectoryAdvert.should_receive(:all)
      get "index"
    end

    it "assigns @directory_adverts" do
      get "index"
      assigns(:directory_adverts).should_not be_nil
    end
  end

  describe "GET new" do
    let(:directory_advert) { mock_model(DirectoryAdvert).as_null_object }

    before do
      DirectoryAdvert.stub(:new).and_return(directory_advert)
    end

    it "instantiates a new directory advert" do
      DirectoryAdvert.should_receive(:new)
      get "new"
    end

    it "assigns @directory_advert" do
      get "new"
      assigns(:directory_advert).should_not be_nil
    end
  end

  describe "GET show" do
    let(:directory_advert) { mock_model(DirectoryAdvert).as_null_object }

    it "finds a directory advert specified by param[:id]" do
      DirectoryAdvert.should_receive(:find_by_id).with("1")
      get "show", :id => "1"
    end

    context "when the advert is found" do
      let(:advert) { mock_model(Advert).as_null_object }
      let(:category) { mock_model(Category).as_null_object }
      let(:resort) { mock_model(Resort).as_null_object }
      let(:country) { mock_model(Country).as_null_object }

      before do
        DirectoryAdvert.stub(:find_by_id).and_return(directory_advert)
        directory_advert.stub(:current_advert).and_return(advert)
        directory_advert.stub(:category).and_return(category)
        directory_advert.stub(:resort).and_return(resort)
        resort.stub(:country).and_return(country)
      end

      it "assigns @directory_advert" do
        get "show", { :id => "1" }
        assigns[:directory_advert].should equal(directory_advert)
      end

      it "sets the default page title" do
        directory_advert.stub(:business_name).and_return("Monkey Bar")
        category.stub(:name).and_return("bars")
        resort.stub(:name).and_return("Chamonix")
        country.stub(:name).and_return("France")
        controller.should_receive(:default_page_title).with(anything())
        get "show", { :id => 1 }
      end

      it "records a view" do
        advert.should_receive(:record_view)
        get "show", { :id => 1 }
      end
    end

    context "when the advert is not found" do
      before do
        DirectoryAdvert.stub(:find_by_id).and_return(nil)
      end

      it "renders not found" do
        get "show", { :id => 1 }
        response.status.should eql 404
      end
    end
  end

  describe "POST create" do
    let(:directory_advert) { mock_model(DirectoryAdvert).as_null_object }

    before do
      DirectoryAdvert.stub(:new).and_return(directory_advert)
      directory_advert.stub(:default_months).and_return(12)
      directory_advert.stub(:user_id).and_return(1)
    end

    def post_valid
      post "create", directory_advert: { category_id: '1', business_address: '123 av', resort_id: ['1'] }
    end

    it "instantiates a new directory advert" do
      DirectoryAdvert.should_receive(:new).with({"category_id" => "1", "business_address" => "123 av"}).and_return(directory_advert)
      post_valid
    end

    it "associates the advert with the current user" do
      directory_advert.should_receive(:user_id=).with(current_user.id)
      post_valid
    end

    context "when the directory advert saves successfully" do
      before do
        directory_advert.stub(:save).and_return(true)
      end

      it "sets a flash[:notice] message" do
        post_valid
        flash[:notice].should eq("Your directory advert was successfully created.")
      end

      it "redirects to the basket" do
        post_valid
        response.should redirect_to(basket_path)
      end
    end

    context "when the directory advert fails to save" do
      before do
        directory_advert.stub(:save).and_return(false)
      end

      it "assigns @directory_advert" do
        post_valid
        assigns[:directory_advert].should eq(directory_advert)
      end

      it "renders the new template" do
        post_valid
        response.should render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    let(:directory_advert) { mock_model(DirectoryAdvert).as_null_object }

    before do
      DirectoryAdvert.stub(:find).and_return(directory_advert)
    end

    it 'finds a directory advert specified by param[:id]' do
      DirectoryAdvert.should_receive(:find).with('1')
      delete :destroy, id: '1'
    end

    context 'when not owned or admin' do
      before { controller.should_receive(:owned_or_admin?).with(directory_advert).and_return(false) }

      it 'responds with 404' do
        delete :destroy, id: '1'
        response.status.should eq 404
      end
    end

    context 'when owned or admin' do
      before { controller.should_receive(:owned_or_admin?).with(directory_advert).and_return(true) }

      it 'destroys a directory advert' do
        directory_advert.should_receive(:destroy)
        delete :destroy, :id => "1"
      end

      context 'when admin' do
        before { controller.stub(:admin?).and_return(true) }

        it 'redirects to directory adverts page' do
          delete :destroy, :id => "1"
          response.should redirect_to(directory_adverts_path)
        end
      end

      context 'when not admin' do
        before { controller.stub(:admin?).and_return(false) }

        it 'redirects to My Adverts' do
          delete :destroy, :id => "1"
          response.should redirect_to(my_adverts_path)
        end
      end
    end
  end
end
