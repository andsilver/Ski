class FavouritesController < ApplicationController
  before_action :unregistered_user_required

  def index
    @properties = @unregistered_user.favourite_properties
  end

  def create
    @favourite = Favourite.new(favourite_params)
    @favourite.unregistered_user_id = @unregistered_user.id
    @favourite.save

    redirect_to(@favourite.property, notice: t('favourites.added'))
  end

  def destroy
    @favourite = Favourite.find_by(id: params[:id])
    if @favourite
      if @favourite.unregistered_user.id == @unregistered_user.id
        @favourite.destroy
      end
      redirect_to(@favourite.property, notice: t('favourites.removed'))
    else
      redirect_to home_path
    end
  end

  protected

  def favourite_params
    params.require(:favourite).permit(:property_id)
  end
end
