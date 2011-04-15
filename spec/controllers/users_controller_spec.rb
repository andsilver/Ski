require 'spec_helper'

describe UsersController do
  let(:user) { mock_model(User).as_null_object }

  before do
    User.stub(:new).and_return(user)
  end

  describe "GET show" do
  end

  describe "GET new" do
    it "instantiates a new user" do
      User.should_receive(:new)
      get :new
    end

    it "assigns @user" do
      get :new
      assigns[:user].should equal(user)
    end
  end

  describe "POST create" do
    let(:role) { mock_model(Role).as_null_object }
    let(:params) { { :user => { "name" => "Carey", "role_id" => "1" }} }

    before do
      Role.stub(:find_by_id).and_return(role)
    end

    it "instantiates a new user with the given params" do
      User.should_receive(:new).with(params[:user])
      post :create, params
    end

    it "finds the selected role" do
      Role.should_receive(:find_by_id).with("1")
      post :create, params
    end

    context "when the role is valid" do
      before do
        role.stub(:select_on_signup?).and_return(true)
      end

      it "assigns @user.role_id" do
        user.should_receive(:role_id=).with(role.id)
        post :create, params
      end
    end

    context "when the role is not valid" do
      before do
        role.stub(:select_on_signup?).and_return(false)
      end

      it "does not assign @user.role_id" do
        user.should_not_receive(:role_id=)
        post :create, params
      end
    end

    context "when the user saves successfully" do
      before do
        user.stub(:save).and_return(true)
      end

      it "sets a flash[:notice] message" do
        post :create, params
        flash[:notice].should eq("Your account was successfully created.")
      end

      it "redirects to the advertise page" do
        post :create, params
        response.should redirect_to(advertise_path)
      end
    end

    context "when the user fails to save" do
      before do
        user.stub(:save).and_return(false)
      end

      it "assigns @user" do
        post :create, params
        assigns[:user].should eq(user)
      end

      it "renders the new template" do
        post :create, params
        response.should render_template("new")
      end
    end
  end

  describe "GET edit" do
  end

  describe "PUT update" do
  end
end
