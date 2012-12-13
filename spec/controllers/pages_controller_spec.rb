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

  describe 'PUT #update' do
    it 'finds the page' do
      Page.should_receive(:find).with('1').and_return(page)
      put 'update', id: '1'
    end

    context 'when the page updates successfully' do
      before do
        Page.stub(:find).and_return(page(update_attributes: true))
      end

      it 'redirects to the edit page' do
        put 'update', id: '1'
        response.should redirect_to(edit_page_path(page))
      end
    end
  end
end
