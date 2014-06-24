require 'rails_helper'

describe ImagesController do
  let(:website) { double(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

  describe 'GET index' do
    it 'assigns all images belonging to the current user to @images' do
      user = double(User, images: :images)
      controller.stub(:current_user).and_return(user)
      get 'index'
      expect(assigns(:images)).to eq :images
    end
  end

  describe 'POST create' do
    context 'when image saves' do
      before do
        Image.any_instance.stub(:save).and_return(true)
        controller.stub(:object).and_return(FactoryGirl.create(:property))
      end

      context 'when image height or width > 800' do
        let(:mock_image) { double(Image).as_null_object }

        before do
          Image.stub(:new).and_return(mock_image)
          mock_image.stub(:height).and_return(1024)
          mock_image.stub(:width).and_return(768)
        end

        it 'sizes the original image' do
          mock_image.should_receive(:size_original!).with(800, :longest_side)
          post :create, image: { source_url: '#' }
        end
      end
    end
  end

  describe 'DELETE destroy' do
    let(:image) { double(Image).as_null_object }

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
