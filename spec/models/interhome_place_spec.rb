require "rails_helper"

RSpec.describe InterhomePlace, type: :model do
  before do
    InterhomePlace.create!(code: "9999", name: "Lakeside", full_name: "United Kingdom > Doncaster > Lakeside")
  end

  it { should validate_uniqueness_of(:code).case_insensitive }
end
