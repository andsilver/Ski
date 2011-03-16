class AdvertsController < ApplicationController
  before_filter :user_required

  def basket
    @adverts = @current_user.adverts_in_basket
  end
end
