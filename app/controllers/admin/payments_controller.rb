module Admin
  class PaymentsController < AdminController
    def index
      @payments = Payment.order("created_at DESC")
    end

    def show
      @payment = Payment.find(params[:id])
    end
  end
end
