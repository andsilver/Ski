require "rails_helper"

describe PaginationHelper do
  class Collection
    cattr_reader :per_page
    @@per_page = 5

    def count
    end

    def current_page
    end
  end

  let(:collection) { Collection.new }

  before { allow(collection).to receive(:first).and_return(collection) }

  describe "pagination_start" do
    subject { pagination_start(collection) }

    context "when page is nil" do
      before { allow(collection).to receive(:current_page).and_return(nil) }

      it { should eq(1) }
    end

    context "when page is 3" do
      before { allow(collection).to receive(:current_page).and_return(3) }

      it { should eq(11) }
    end
  end

  describe "pagination_end" do
    subject { pagination_end(collection) }

    before { allow(collection).to receive(:count).and_return(7) }

    context "when page is not last page" do
      before { allow(collection).to receive(:current_page).and_return(1) }

      it { should eq(5) }
    end

    context "when page is last page" do
      before { allow(collection).to receive(:current_page).and_return(2) }

      it { should eq(7) }
    end
  end
end
