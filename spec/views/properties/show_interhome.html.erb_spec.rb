require 'rails_helper'

RSpec.describe 'properties/show_interhome.html.erb', type: :view do
  let(:accommodation) { FactoryGirl.create(:interhome_accommodation) }
  let(:property) { FactoryGirl.create(:property, interhome_accommodation: accommodation).decorate }

  before do
    assign(:accommodation, accommodation)
    assign(:property, property)
  end

  it 'renders' do
    render
  end
end
