# coding: utf-8

class ImagesController < ApplicationController
  before_filter :find_object, only: [:new, :edit, :create]

  def index
    @images = @current_user.images
  end

  def new
    @image = Image.new
    if session[:image_mode] == 'property'
      @image.property_id = session[:property_id]
    end
  end

  def create
    @image = Image.new(image_params)

    if session[:image_mode] == 'property'
      @image.property_id = session[:property_id]
    elsif 'country' == session[:image_mode]
      remove_previous_image
    end

    @image.user_id = @current_user.id

    begin
      if @image.save
        set_main_image_if_first
        redirect_to(new_image_path, notice: t('images_controller.image_uploaded')) and return
      end
    rescue
    end

    @image.destroy
    redirect_to(new_image_path, notice: t('images_controller.problem_uploading'))
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])

    if @image.update_attributes(image_params)
      redirect_to({ action: 'index' }, notice: t('images_controller.saved'))
    else
      render action: 'edit'
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    redirect_to({ action: 'index' }, notice: t('images_controller.deleted'))
  end

  protected

  def set_main_image_if_first
    if session[:image_mode] == 'property'
      return if @object.images.count > 1
    end

    @object.image_id = @image.id
    @object.save
  end

  def find_object
    @object = object_class.find(the_object_id)
  end

  def object_class
    Kernel.const_get(session[:image_mode].classify)
  end

  def the_object_id
    session[session[:image_mode] + '_id']
  end

  def remove_previous_image
    @object.image.destroy if @object.image
  end

  def image_params
    params.require(:image).permit(:image, :source_url)
  end
end
