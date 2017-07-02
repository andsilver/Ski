require 'rails_helper'

RSpec.describe 'Trip Advisor locations admin', type: :request do
  before do
    FactoryGirl.create(:website)
    allow_any_instance_of(ApplicationController)
      .to receive(:admin?)
      .and_return(true)
  end

  describe 'GET /admin/trip_advisor_locations' do
    it 'lists each top-level location' do
      africa = FactoryGirl.create(
        :trip_advisor_location, name: 'Africa', parent: nil
      )
      FactoryGirl.create(
        :trip_advisor_location, name: 'Madagascar', parent: africa
      )

      get admin_trip_advisor_locations_path

      assert_select 'li', text: 'Africa'
      assert_select 'li', text: 'Madagascar', count: 0
    end
  end

  describe 'GET /admin/trip_advisor_locations/:id' do
    let!(:africa) do
      FactoryGirl.create(:trip_advisor_location, name: 'Africa', parent: nil)
    end
    let!(:madagascar) do
      FactoryGirl.create(
        :trip_advisor_location, name: 'Madagascar', parent: africa
      )
    end

    it 'links to its child locations' do
      get admin_trip_advisor_location_path(africa)
      assert_select "a[href='#{admin_trip_advisor_location_path(madagascar)}']"
    end

    it 'links to its parent location' do
      get admin_trip_advisor_location_path(madagascar)
      assert_select "a[href='#{admin_trip_advisor_location_path(africa)}']"
    end
  end
end
