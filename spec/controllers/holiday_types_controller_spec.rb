require 'spec_helper'

describe HolidayTypesController do
  let(:website) { mock_model(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

  describe 'GET show' do
    it 'finds holiday type by its slug' do
      HolidayType.should_receive(:find_by).with(slug: 'slug')
      get 'show', { 'id' => 'slug' }
    end

    it 'assigns @holiday_type' do
      ht = mock_model(HolidayType)
      HolidayType.stub(:find_by).and_return(ht)
      get 'show', { 'id' => 'slug' }
      expect(assigns('holiday_type')).to eq ht
    end

    context 'when holiday type not found' do
      before { HolidayType.stub(:find_by).and_return(nil) }

      it 'renders 404' do
        get 'show', { 'id' => 'slug' }
        expect(response.status).to eq 404
      end
    end
  end
end
