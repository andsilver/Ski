require 'spec_helper'

describe Basket do
  describe '#initialize' do
    it 'sets @lines to an empty array' do
      b = Basket.new(user: FactoryGirl.build(:user))
      b.lines.should eq []
    end
  end

  describe '#prepare' do
    it 'adds a line for windows' do
      b = Basket.new(user: FactoryGirl.build(:user))
      b.should_receive(:add_line_for_windows)
      b.prepare
    end

    it 'adds lines for adverts' do
      b = Basket.new(user: FactoryGirl.build(:user))
      b.should_receive(:add_lines_for_adverts)
      b.prepare
    end

    it 'applies any price override' do
      b = Basket.new(user: FactoryGirl.build(:user))
      b.should_receive(:apply_price_override)
      b.prepare
    end
  end

  describe '#add_line_for_windows' do
    pending
  end

  describe '#add_lines_for_adverts' do
    pending
  end

  describe '#apply_price_override' do
    pending
  end

  describe '#subtotal' do
    it "returns the sum of each line's price" do
      b = Basket.new(user: FactoryGirl.create(:user))

      l1 = BasketLine.new
      l1.price = 3
      l2 = BasketLine.new
      l2.price = 4
      l3 = BasketLine.new
      l3.price = -2

      b.lines = [l1, l2, l3]
      b.subtotal.should eq 5
    end
  end
end
