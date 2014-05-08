require 'spec_helper'

describe 'layouts/_resort_nav' do
  let(:resort) { mock_model(Resort).as_null_object }
  before { assign(:resort, resort) }

  context 'when resort has guide' do
    before { resort.stub(:has_resort_guide?).and_return(true) }

    it 'links to the resort guide' do
      render
      expect(rendered).to have_content(t('layouts.resort_nav.resort_guide'))
    end
  end

  context 'when resort has no guide' do
    before { resort.stub(:has_resort_guide?).and_return(false) }

    it 'does not link to the resort guide' do
      render
      expect(rendered).not_to have_content(t('layouts.resort_nav.resort_guide'))
    end
  end
end
