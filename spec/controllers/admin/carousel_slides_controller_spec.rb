require "rails_helper"

module Admin
  RSpec.describe CarouselSlidesController do
    let(:website) { double(Website).as_null_object }

    before do
      allow(Website).to receive(:first).and_return(website)
    end

    def mock_carousel_slide(stubs = {})
      @mock_carousel_slide ||= double(CarouselSlide, stubs)
    end

    context "as admin" do
      before { signed_in_as_admin }

      context "moving" do
        let!(:first) { FactoryBot.create(:carousel_slide) }
        let!(:last)  { FactoryBot.create(:carousel_slide) }

        describe "GET move_up" do
          it "moves the carousel slide up the list" do
            get :move_up, params: {id: last.id}
            expect(last.reload.position).to eq 1
          end

          it "sets flash notice" do
            get :move_up, params: {id: last.id}
            expect_moved_notice
          end

          it "redirects to index" do
            get :move_up, params: {id: last.id}
            expect(response).to redirect_to(admin_carousel_slides_path)
          end
        end

        describe "GET move_down" do
          it "moves the carousel slide down the list" do
            get :move_down, params: {id: first.id}
            expect(first.reload.position).to eq 2
          end

          it "sets flash notice" do
            get :move_down, params: {id: first.id}
            expect_moved_notice
          end

          it "redirects to index" do
            get :move_down, params: {id: first.id}
            expect(response).to redirect_to(admin_carousel_slides_path)
          end
        end

        def expect_moved_notice
          expect(flash.notice).to eq I18n.t("notices.moved")
        end
      end
    end

    def find_requested_carousel_slide(stubs = {})
      expect(CarouselSlide).to receive(:find_by)
        .with(id: "37", website_id: website.id)
        .and_return(mock_carousel_slide(stubs))
    end
  end
end
