require 'spec_helper'

describe InterhomePlaceResortsController do
  let(:website) { mock_model(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

  context 'when signed in as admin' do
    before do
      controller.stub(:admin?).and_return(true)
    end

    describe 'POST create' do
      let(:interhome_place_resort) { mock_model(InterhomePlaceResort).as_null_object }
      let(:params) { { interhome_place_resort: { 'resort_id' => '1', 'interhome_place_code' => 'AD_1_1450'} } }

      before do
        InterhomePlaceResort.stub(:new).and_return(interhome_place_resort)
      end

      it 'instantiates a new Interhome place resort with the given params' do
        InterhomePlaceResort.should_receive(:new).with(params[:interhome_place_resort])
        post 'create', params
      end

      it 'redirects to the edit resort page' do
        post 'create', params
        expect(response).to redirect_to(edit_admin_resort_path(id: '1'))
      end

      context 'when the Interhome place resort saves successfully' do
        before do
          interhome_place_resort.stub(:save).and_return(true)
        end

        it 'sets a flash[:notice] message' do
          post 'create', params
          expect(flash[:notice]).to eq("Created.")
        end
      end

      context 'when the Interhome place resort fails to save' do
        before do
          interhome_place_resort.stub(:save).and_return(false)
        end

        it 'sets a flash[:notice] message' do
          post 'create', params
          expect(flash[:notice]).to eq("Could not link that Interhome place to this resort.")
        end
      end
    end

    describe 'DELETE destroy' do
      let(:interhome_place_resort) { mock_model(InterhomePlaceResort).as_null_object }

      before do
        InterhomePlaceResort.stub(:find).and_return(interhome_place_resort)
        interhome_place_resort.stub(:resort_id).and_return('2')
      end

      it 'finds the Interhome place resort' do
        InterhomePlaceResort.should_receive(:find).with('1')
        delete 'destroy', id: '1'
      end      

      it 'destroys the Interhome place resort' do
        interhome_place_resort.should_receive(:destroy)
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
