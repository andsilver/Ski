require 'rails_helper'

describe Admin::UsersController do
  let(:website) { double(Website).as_null_object }
  let(:user) { double(User).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
    allow(User).to receive(:new).and_return(user)
  end
end
