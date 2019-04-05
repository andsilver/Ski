shared_examples_for "an image object requirer" do |method, action, params|
  let(:country) { FactoryBot.create(:country) }
  let(:image_mode) { "country" }
  let(:country_id) { country.id }

  before do
    allow(controller).to receive(:current_user).and_return(User.new)
    session[:image_mode] = image_mode
    send(method, action, params)
  end

  context "when session[:image_mode] unset" do
    let(:image_mode) { nil }

    it "redirects to index" do
      expect(response).to redirect_to images_path
    end
  end

  context "when session[(:image_mode)_id] unset" do
    let(:country_id) { nil }

    it "redirects to index" do
      expect(response).to redirect_to images_path
    end
  end
end
