require "rails_helper"

RSpec.describe "cms/index.html.slim", type: :view do
  it "displays number of delayed job workers" do
    allow(view).to receive(:delayed_job_workers).and_return(4)
    render
    expect(rendered).to have_content "There are 4 delayed_job workers running."
  end
end
