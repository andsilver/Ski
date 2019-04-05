shared_examples_for "a user requirer" do |method, action|
  before do
    allow(controller).to receive(:current_user).and_return(current_user)
    send(method, action)
  end

  context "when not signed in" do
    let(:current_user) { nil }

    it "redirects to sign in page" do
      expect(response).to redirect_to sign_in_path
    end
  end
end
