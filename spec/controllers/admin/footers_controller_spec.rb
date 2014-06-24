require 'rails_helper'

describe Admin::FootersController do
  let(:website) { double(Website).as_null_object }

  def mock_footer(stubs = {})
    @mock_footer ||= double(Footer, stubs)
  end

  before do
    Website.stub(:first).and_return(website)
  end

  context 'when signed in as admin' do
    before { signed_in_as_admin }

    describe 'GET index' do
      before { controller.stub(:use_default_footer) }

      it 'finds all footers' do
        Footer.should_receive(:all)
        get 'index'
      end

      it 'assigns @footers' do
        Footer.stub(:all).and_return(:footers)
        get 'index'
        expect(assigns(:footers)).to eq :footers
      end
    end

    describe 'GET new' do
      it 'assigns a new instance of Footer to @footer' do
        Footer.should_receive(:new).and_return(mock_footer)
        get 'new'
        expect(assigns(:footer)).to eq mock_footer
      end
    end

    describe 'POST create' do
      context 'on successful save' do
        before { Footer.stub(:new).and_return(mock_footer(save: true)) }

        it 'redirects to admin footers path' do
          post 'create', id: '1', footer: { 'some' => 'params' }
          expect(response).to redirect_to admin_footers_path
        end
      end
    end

    describe 'PATCH update' do
      context 'on successful update' do
        before { Footer.stub(:find).and_return(mock_footer(update_attributes: true)) }

        it 'redirects to admin footers path' do
          patch 'update', id: '1', footer: { 'some' => 'params' }
          expect(response).to redirect_to admin_footers_path
        end
      end
    end

    describe 'DELETE destroy' do
      context 'when footer found' do
        before { Footer.stub(:find).and_return(mock_footer) }

        it 'destroys the footer' do
          mock_footer.should_receive(:destroy)
          delete 'destroy', id: '1'
        end

        it 'redirects to admin footers path' do
          mock_footer.stub(:destroy)
          delete 'destroy', id: '1'
          expect(response).to redirect_to admin_footers_path
        end
      end
    end
  end
end
