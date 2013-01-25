require 'spec_helper'

feature 'Late Availability' do
  before { setup_website }

  scenario 'it has a page' do
    visit '/late-availability'
    page.status_code.should == 200
  end

  def setup_website
    Website.create!
  end
end
