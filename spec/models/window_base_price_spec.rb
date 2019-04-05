require "rails_helper"

describe WindowBasePrice do
  before do
    WindowBasePrice.create!
  end

  it { should validate_uniqueness_of(:quantity) }
end
