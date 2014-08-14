require 'rails_helper'

describe UnregisteredUser do
  it { should have_many(:favourites) }
  it { should have_many(:favourite_properties).through(:favourites) }
end
