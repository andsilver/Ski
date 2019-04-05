class ImagesController < ApplicationController
  before_action :require_object, only: [:new, :edit, :create]

  before_action :admin_required, only: [:show]

  before_action :user_required, only: [:index]

  def index
    @images = current_user.images
  end

  def show
    @image = Image.find(params[:id])
    render layout: "admin"
  end

  def new
    @image = Image.new
    if session[:image_mode] == "property"
      @image.property_id = session[:property_id]
    end
  end

  def create
    @image = Image.new(image_params)

    if session[:image_mode] == "property"
      @image.property_id = session[:property_id]
    elsif session[:image_mode] == "country"
      remove_previous_image
    end

    @image.user = current_user

    begin
      if @image.save
        set_main_image_if_first
        if @image.height > 800 || @image.width > 800
          @image.size_original! 800, :longest_side
        end
        redirect_to(new_image_path, notice: t("images_controller.image_uploaded")) && return
      end
    rescue
    end

    @image.destroy
    redirect_to(new_image_path, notice: t("images_controller.problem_uploading"))
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])

    if @image.update_attributes(image_params)
      redirect_to({action: "index"}, notice: t("images_controller.saved"))
    else
      render action: "edit"
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    destination = request.referer || images_path
    redirect_to(destination, notice: t("images_controller.deleted"))
  end

  protected

  def set_main_image_if_first
    if session[:image_mode] == "property"
      return if object.images.count > 1
    end

    object.image_id = @image.id
    object.save
  end

  # Ensures we have a valid object to add an image to. The type of object and
  # its ID should be stored in the session.
  def require_object
    object
  rescue
    redirect_to images_path, notice: t("images_controller.invalid_object")
  end

  def object
    @object ||= object_class.find(the_object_id)
  end

  def object_class
    Kernel.const_get(session[:image_mode].classify)
  end

  def the_object_id
    session[session[:image_mode] + "_id"]
  end

  def remove_previous_image
    object.image&.destroy
  end

  def image_params
    params.require(:image).permit(:image, :source_url)
  end
end
