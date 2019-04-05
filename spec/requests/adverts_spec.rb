require "rails_helper"

RSpec.describe "Create an order", type: :request do
  fixtures :currencies

  before { FactoryBot.create(:website) }
  let(:user) { FactoryBot.create(:user) }

  describe "GET /adverts/place_order" do
    before do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user).and_return(user)
    end

    let(:order) { FactoryBot.create(:order) }

    it "deletes a previous unpaid order, if any" do
      session = {order_id: 1}
      allow_any_instance_of(ApplicationController)
        .to receive(:session).and_return(session)

      allow(Order).to receive(:find_by).with(id: 1).and_return(order)
      allow(order).to receive(:status).and_return(Order::WAITING_FOR_PAYMENT)
      expect(order).to receive(:destroy)

      # ignore order creation
      allow(Order).to receive(:new).and_return(order)
      allow(order).to receive(:save!).and_return(order)

      get place_order_adverts_path
    end

    it "creates a new order" do
      allow(Order).to receive(:new).and_return(order)
      expect(Order).to receive(:new)

      # ignore saving of the order
      allow(order).to receive(:save!).and_return(order)

      get place_order_adverts_path
    end

    it "copies the user's details to the order" do
      allow(Order).to receive(:new).and_return(order)
      allow(order).to receive(:user_id).and_return(user.id)
      expect(order.user_id).to eq user.id

      # ignore saving of the order
      allow(order).to receive(:save!).and_return(order)

      get place_order_adverts_path
    end

    it "set the currency as GBP" do
      allow(Order).to receive(:new).and_return(order)
      allow(order).to receive(:currency).and_return(Currency.gbp)
      expect(order.currency.code).to eq "GBP"

      # ignore saving of the order
      allow(order).to receive(:save!).and_return(order)

      get place_order_adverts_path
    end
  end
end
