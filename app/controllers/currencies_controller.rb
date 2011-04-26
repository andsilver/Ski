class CurrenciesController < ApplicationController
  before_filter :admin_required
  before_filter :find_currency, :only => [:edit, :update]

  def index
    @currencies = Currency.all(:order => :code)
  end

  def new
    @currency = Currency.new
  end

  def create
    @currency = Currency.new(params[:currency])

    if @currency.save
      redirect_to(currencies_path, :notice => 'Currency created.')
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @currency.update_attributes(params[:currency])
      redirect_to(currencies_path, :notice => 'Saved')
    else
      render "edit"
    end
  end

  def update_exchange_rates
    Currency.update_exchange_rates
    Property.normalise_prices
    redirect_to currencies_path, :notice => 'Exchange rates updated.'
  end

  protected

  def find_currency
    @currency = Currency.find(params[:id])
  end
end
