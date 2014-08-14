require 'rails_helper'

describe Admin::UsersController do
  let(:website) { mock_model(Website).as_null_object }
  let(:user) { mock_model(User).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    User.stub(:new).and_return(user)
  end
end
