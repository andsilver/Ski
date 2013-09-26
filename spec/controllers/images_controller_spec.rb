require 'spec_helper'

describe ImagesController do
  let(:website) { mock_model(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

  describe 'GET index' do
    it 'assigns all images belonging to the current user to @images' do
      user = mock_model(User, images: :images)
      controller.stub(:current_user).and_return(user)
      get 'index'
      expect(assigns(:images)).to eq :images
    end
  end

  describe 'DELETE destroy' do
    let(:image) { mock_model(Image).as_null_object }

    it 'finds the image' do
      Image.should_receive(:find).with('1').and_return(image)
      delete 'destroy', id: '1'
    end

    context 'when image is found' do
      before do
        Image.stub(:find).and_return(image)
      end

      it 'redirects to the referrer' do
        request.stub(:referer).and_return('http://example.org')
        delete 'destroy', id: '1'
        expect(response).to redirect_to('http://example.org')
      end
    end
  end
end
