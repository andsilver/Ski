class DirectoryAdvertsController < ApplicationController
  before_filter :user_required

  def my
    @directory_adverts = @current_user.directory_adverts
  end

  def new
    @directory_advert = DirectoryAdvert.new
  end

  def create
    @directory_advert = DirectoryAdvert.new(params[:directory_advert])
    if @directory_advert.save
      redirect_to my_directory_adverts_path,
        :notice => "Your directory advert was successfully created."
    else
      render "new"
    end
  end
end
