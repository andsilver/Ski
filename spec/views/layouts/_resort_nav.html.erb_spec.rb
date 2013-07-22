require 'spec_helper'

describe 'layouts/_resort_nav' do
  let(:resort) { mock_model(Resort).as_null_object }
  before { assign(:resort, resort) }

  context 'when a ski resort' do
    before { resort.stub(:ski?).and_return(true) }

    it 'links to the resort guide' do
      render
      expect(rendered).to have_content(t('layouts.resort_nav.resort_guide'))
    end
  end

  context 'when not a ski resort' do
    before { resort.stub(:ski?).and_return(false) }

    it 'does not link to the resort guide' do
      render
      expect(rendered).not_to have_content(t('layouts.resort_nav.resort_guide'))
    end
  end
end
