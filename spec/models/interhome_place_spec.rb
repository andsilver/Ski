require 'rails_helper'

describe InterhomePlace do
  before do
    InterhomePlace.create!(code: '9999', name: 'Lakeside', full_name: 'United Kingdom > Doncaster > Lakeside')
  end

  it { should validate_uniqueness_of(:code) }
end
