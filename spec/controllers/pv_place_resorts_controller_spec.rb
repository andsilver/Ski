require 'rails_helper'

describe PvPlaceResortsController do
  let(:website) { double(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

  context 'when signed in as admin' do
    before do
      controller.stub(:admin?).and_return(true)
    end

    describe 'POST create' do
      let(:pv_place_resort) { double(PvPlaceResort).as_null_object }
      let(:params) { { pv_place_resort: { 'resort_id' => '1', 'pv_place_code' => 'FR-FR-05-FR-SEC'} } }

      before do
        PvPlaceResort.stub(:new).and_return(pv_place_resort)
      end

      it 'instantiates a new P&V place resort with the given params' do
        PvPlaceResort.should_receive(:new).with(params[:pv_place_resort])
        post 'create', params
      end

      it 'redirects to the edit resort page' do
        post 'create', params
        expect(response).to redirect_to(edit_admin_resort_path(id: '1'))
      end

      context 'when the P&V place resort saves successfully' do
        before do
          pv_place_resort.stub(:save).and_return(true)
        end

        it 'sets a flash[:notice] message' do
          post 'create', params
          expect(flash[:notice]).to eq("Created.")
        end
      end

      context 'when the P&V place resort fails to save' do
        before do
          pv_place_resort.stub(:save).and_return(false)
        end

        it 'sets a flash[:notice] message' do
          post 'create', params
          expect(flash[:notice]).to eq("Could not link that P&V place to this resort.")
        end
      end
    end

    describe 'DELETE destroy' do
      let(:pv_place_resort) { double(PvPlaceResort).as_null_object }

      before do
        PvPlaceResort.stub(:find).and_return(pv_place_resort)
        pv_place_resort.stub(:resort_id).and_return('2')
      end

      it 'finds the P&V place resort' do
        PvPlaceResort.should_receive(:find).with('1')
        delete 'destroy', id: '1'
      end      

      it 'destroys the P&V place resort' do
        pv_place_resort.should_receive(:destroy)
        delete 'destroy', id: '1'
      end

      it 'redirects to the edit resort page' do
        delete 'destroy', id: '1'
        expect(response).to redirect_to(edit_admin_resort_path(id: '2'))
      end

      it 'sets a flash[:notice] message' do          
        delete 'destroy', id: '1'
        expect(flash[:notice]).to eq('Unlinked.')
      end
    end
  end
end
