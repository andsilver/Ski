class CurrenciesController < ApplicationController
  before_filter :admin_required
  before_filter :no_browse_menu
  before_filter :find_currency, only: [:edit, :update]

  layout 'admin'

  def index
    @currencies = Currency.order('code')
  end

  def new
    @currency = Currency.new
  end

  def create
    @currency = Currency.new(currency_params)

    if @currency.save
      redirect_to(currencies_path, notice: t('notices.created'))
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @currency.update_attributes(currency_params)
      redirect_to(currencies_path, notice: t('notices.saved'))
    else
      render 'edit'
    end
  end

  def update_exchange_rates
    Currency.update_exchange_rates
    redirect_to currencies_path, notice: t('currencies_controller.exchange_rates_updated')
  end

  protected

  def find_currency
    @currency = Currency.find(params[:id])
  end

  def currency_params
    params.require(:currenct).permit(:code, :in_euros, :name, :pre, :unit)
  end
end
