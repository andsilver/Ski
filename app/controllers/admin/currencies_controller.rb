module Admin
  class CurrenciesController < AdminController
    before_action :find_currency, only: [:edit, :update]

    def index
      @currencies = Currency.order("code")
    end

    def new
      @currency = Currency.new
    end

    def create
      @currency = Currency.new(currency_params)

      if @currency.save
        redirect_to(admin_currencies_path, notice: t("notices.created"))
      else
        render "new"
      end
    end

    def edit
    end

    def update
      if @currency.update_attributes(currency_params)
        redirect_to(admin_currencies_path, notice: t("notices.saved"))
      else
        render "edit"
      end
    end

    def update_exchange_rates
      Currency.update_exchange_rates
      redirect_to admin_currencies_path, notice: t("currencies_controller.exchange_rates_updated")
    end

    protected

    def find_currency
      @currency = Currency.find(params[:id])
    end

    def currency_params
      params.require(:currency).permit(:code, :in_euros, :name, :pre, :unit)
    end
  end
end
