require 'spec_helper'

describe PagesController do
  let(:website) { mock_model(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    controller.stub(:admin?).and_return(true)
  end

  def page(stubs = {})
    @page ||= mock_model(Page, stubs).as_null_object
  end

  def put_update
    put 'update', id: '1', page: { title: 'T' }
  end

  describe 'PUT update' do
    it 'finds the page' do
      Page.should_receive(:find).with('1').and_return(page)
      put_update
    end

    context 'when the page updates successfully' do
      before do
        Page.stub(:find).and_return(page(update_attributes: true))
      end

      it 'redirects to the edit page' do
        put_update
        expect(response).to redirect_to(edit_page_path(page))
      end
    end
  end

  describe 'GET show' do
    it 'finds the page by path' do
      # received twice and found the first time by ApplicationController#page_defaults
      Page.should_receive(:find_by_path).with('/pages/slug').twice.and_return(page(content: ''))
      get 'show', id: 'slug'
    end
  end

  describe 'GET copy' do
    it 'finds the page' do
      Page.should_receive(:find).with('1').and_return(page)
      get 'copy', id: '1'
    end

    context 'when the page is found' do
      let(:page) { mock_model(Page).as_null_object }

      it 'duplicates the page' do
        Page.stub(:find).and_return(FactoryGirl.create(:page, title: 'xyzzy'))
        get 'copy', id: '1'
        expect(assigns(:page).title).to eq 'xyzzy'
        expect(assigns(:page).new_record?).to be_true
      end

      it 'renders the new template' do
        Page.stub(:find).and_return(page)
        get 'copy', id: '1'
        expect(response).to render_template('new')
      end
    end
  end
end
