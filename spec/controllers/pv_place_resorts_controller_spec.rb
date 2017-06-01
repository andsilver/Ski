require 'rails_helper'

describe PvPlaceResortsController do
  let(:website) { double(Website).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
  end

  context 'when signed in as admin' do
    before do
      allow(controller).to receive(:admin?).and_return(true)
    end

    describe 'POST create' do
      let(:pv_place_resort) { double(PvPlaceResort).as_null_object }
      let(:params) { { pv_place_resort: { 'resort_id' => '1', 'pv_place_code' => 'FR-FR-05-FR-SEC'} } }

      before do
        allow(PvPlaceResort).to receive(:new).and_return(pv_place_resort)
      end

      it 'instantiates a new P&V place resort with the given params' do
        expect(PvPlaceResort).to receive(:new).with(params[:pv_place_resort])
        post 'create', params: params
      end

      it 'redirects to the edit resort page' do
        post 'create', params: params
        expect(response).to redirect_to(edit_admin_resort_path(id: '1'))
      end

      context 'when the P&V place resort saves successfully' do
        before do
          allow(pv_place_resort).to receive(:save).and_return(true)
        end

        it 'sets a flash[:notice] message' do
          post 'create', params: params
          expect(flash[:notice]).to eq("Created.")
        end
      end

      context 'when the P&V place resort fails to save' do
        before do
          allow(pv_place_resort).to receive(:save).and_return(false)
        end

        it 'sets a flash[:notice] message' do
          post 'create', params: params
          expect(flash[:notice]).to eq("Could not link that P&V place to this resort.")
        end
      end
    end

    describe 'DELETE destroy' do
      let(:pv_place_resort) { double(PvPlaceResort).as_null_object }

      before do
        allow(PvPlaceResort).to receive(:find).and_return(pv_place_resort)
        allow(pv_place_resort).to receive(:resort_id).and_return('2')
      end

      it 'finds the P&V place resort' do
        expect(PvPlaceResort).to receive(:find).with('1')
        delete 'destroy', params: { id: '1' }
      end

      it 'destroys the P&V place resort' do
        expect(pv_place_resort).to receive(:destroy)
        delete 'destroy', params: { id: '1' }
      end

      it 'redirects to the edit resort page' do
        delete 'destroy', params: { id: '1' }
        expect(response).to redirect_to(edit_admin_resort_path(id: '2'))
      end

      it 'sets a flash[:notice] message' do
        delete 'destroy', params: { id: '1' }
        expect(flash[:notice]).to eq('Unlinked.')
      end
    end
  end
end
