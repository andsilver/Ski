require 'rails_helper'

describe PagesController do
  let(:website) { double(Website).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
    allow(controller).to receive(:admin?).and_return(true)
  end

  def page(stubs = {})
    @page ||= double(Page, stubs).as_null_object
  end

  describe 'POST create' do
    before { post :create, params: { page: page_params } }

    context 'with valid page params' do
      let(:page_params) {{
        title: 'Title',
        path: SecureRandom.hex
      }}

      it 'creates a page' do
        expect(Page.find_by(page_params)).to be
      end

      it 'redirects to pages index' do
        expect(response).to redirect_to(pages_path)
      end
    end

    context 'with invalid page params' do
      let(:page_params) {{
        title: ''
      }}

      it 'renders new' do
        pending
        expect(response).to render_template :new
      end
    end
  end

  def put_update
    put 'update', params: { id: '1', page: { title: 'T' } }
  end

  describe 'PUT update' do
    it 'finds the page' do
      expect(Page).to receive(:find).with('1').and_return(page)
      put_update
    end

    context 'when the page updates successfully' do
      before do
        allow(Page).to receive(:find).and_return(page(update_attributes: true))
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
      expect(Page).to receive(:find_by).with(path: '/pages/slug').twice.and_return(page(content: ''))
      get 'show', params: { id: 'slug' }
    end
  end

  describe 'GET copy' do
    it 'finds the page' do
      expect(Page).to receive(:find).with('1').and_return(page)
      get 'copy', params: { id: '1' }
    end

    context 'when the page is found' do
      let(:page) { double(Page).as_null_object }

      it 'duplicates the page' do
        pending
        allow(Page).to receive(:find).and_return(FactoryGirl.create(:page, title: 'xyzzy'))
        get 'copy', params: { id: '1' }
        expect(assigns(:page).title).to eq 'xyzzy'
        expect(assigns(:page).new_record?).to be_truthy
      end

      it 'renders the new template' do
        pending
        allow(Page).to receive(:find).and_return(page)
        get 'copy', params: { id: '1' }
        expect(response).to render_template('new')
      end
    end
  end
end
