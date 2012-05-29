class FavouritesController < ApplicationController
  before_filter :unregistered_user_required

  def index
    @properties = @unregistered_user.favourite_properties
    @heading_a = t('favourites.favourites')
  end

  def create
    @favourite = Favourite.new(params[:favourite])
    @favourite.unregistered_user_id = @unregistered_user.id
    @favourite.save

    redirect_to(@favourite.property, :notice => t('favourites.added'))
  end

  def destroy
    @favourite = Favourite.find_by_id(params[:id])
    if @favourite
      if @favourite.unregistered_user.id == @unregistered_user.id
        @favourite.destroy
      end
      redirect_to(@favourite.property, :notice => t('favourites.removed'))
    else
      redirect_to home_path
    end
  end
end
