class DirectoryAdvertsController < ApplicationController
  before_filter :no_browse_menu
  before_filter :user_required
  before_filter :find_directory_advert_for_current_user, :only => [:edit, :update, :advertise_now]

  def new
    @directory_advert = DirectoryAdvert.new
  end

  def show
    @directory_advert = DirectoryAdvert.find(params[:id])
    @directory_advert.current_advert.record_view
  end

  def create
    @directory_advert = DirectoryAdvert.new(params[:directory_advert])

    @directory_advert.user_id = @current_user.id

    update_user_details

    if @directory_advert.save
      advert = Advert.new_for(@directory_advert)
      advert.months = 3
      advert.save!
      redirect_to(basket_path, :notice => 'Your directory advert was successfully created.')
    else
      render "new"
    end
  end

  def edit
  end

  def update
    update_user_details
    if @directory_advert.update_attributes(params[:directory_advert])
      redirect_to my_directory_adverts_path,
        :notice => "Your directory advert was successfully updated."
    else
      render "edit"
    end
  end

  def advertise_now
    create_advert
    redirect_to(basket_path, :notice => 'Your directory advert has been added to your basket.')
  end

  protected

  def find_directory_advert_for_current_user
    @directory_advert = DirectoryAdvert.find_by_id_and_user_id(params[:id], @current_user.id)
  end

  def update_user_details
    @current_user.business_name = params[:business_name]
    @current_user.website = params[:website]
    @current_user.description = params[:description]
    @current_user.save
  end

  def create_advert
    advert = Advert.new_for(@directory_advert)
    advert.months = 3
    advert.save!
  end
end
