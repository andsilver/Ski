require "rails_helper"

RSpec.describe "Coupons admin", type: :request do
  before do
    FactoryBot.create(:website)
    allow_any_instance_of(ApplicationController)
      .to receive(:admin?)
      .and_return(true)
  end

  describe "GET /admin/coupons" do
    it "lists coupons" do
      coupon = FactoryBot.create(:coupon)
      get admin_coupons_path
      assert_select "td", content: coupon.code
    end
  end

  describe "GET /admin/coupons/new" do
    it "shows a form" do
      get new_admin_coupon_path
      assert_select "form[action='#{admin_coupons_path}']"
    end
  end

  describe "POST /admin/coupons" do
    context "with valid params" do
      before do
        post(
          admin_coupons_path,
          params: {
            coupon: {
              code: "MCF",
              number_of_adverts: 2,
            },
          }
        )
      end

      it "creates a new coupon" do
        coupon = Coupon.last
        expect(coupon).to be
        expect(coupon.code).to eq "MCF"
        expect(coupon.number_of_adverts).to eq 2
      end

      it "redirects to the coupons index" do
        expect(response).to redirect_to(admin_coupons_path)
      end

      it "sets a flash notice" do
        expect(flash[:notice]).to eq I18n.t("notices.created")
      end
    end

    context "with invalid params" do
      before do
        post(
          admin_coupons_path,
          params: {
            coupon: {
              code: "MCF",
              number_of_adverts: 0,
            },
          }
        )
      end

      it "shows the form again" do
        assert_select "form[action='#{admin_coupons_path}']" do
          assert_select "input[name='coupon[code]'][value='MCF']"
        end
      end
    end
  end

  describe "GET /admin/coupons/:id/edit" do
    it "shows a form to edit the coupon" do
      coupon = FactoryBot.create(:coupon)
      get edit_admin_coupon_path(coupon)
      assert_select "form[action='#{admin_coupon_path(coupon)}']"
    end
  end

  describe "PATCH /admin/coupons/:id" do
    context "with valid params" do
      let(:coupon) { FactoryBot.create(:coupon) }
      let(:country) { FactoryBot.create(:country) }
      before do
        patch(
          admin_coupon_path(coupon),
          params: {
            coupon: {
              code: "MCF",
              number_of_adverts: 2,
            },
          }
        )
      end

      it "updates the coupon" do
        coupon.reload
        expect(coupon.code).to eq "MCF"
        expect(coupon.number_of_adverts).to eq 2
      end

      it "redirects to the coupons index" do
        expect(response).to redirect_to(admin_coupons_path)
      end

      it "sets a flash notice" do
        expect(flash[:notice]).to eq I18n.t("notices.saved")
      end
    end

    context "with invalid params" do
      let(:coupon) { FactoryBot.create(:coupon) }
      before do
        patch(
          admin_coupon_path(coupon),
          params: {coupon: {code: "MCF", number_of_adverts: "0"}}
        )
      end

      it "shows the form again" do
        assert_select "form[action='#{admin_coupon_path(coupon)}']" do
          assert_select "input[name='coupon[code]'][value='MCF']"
        end
      end
    end
  end

  describe "DELETE /admin/coupons/:id" do
    let(:coupon) { FactoryBot.create(:coupon) }
    before { delete admin_coupon_path(coupon) }

    it "deletes the coupon" do
      expect(Coupon.exists?(coupon.id)).to be_falsey
    end

    it "redirects to the coupons index" do
      expect(response).to redirect_to(admin_coupons_path)
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to eq I18n.t("notices.deleted")
    end
  end
end
