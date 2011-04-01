# coding: utf-8

class ImagesController < ApplicationController
  def index
    @images = @current_user.images
  end

  def new
    @image = Image.new
    @image.property_id = session[:property_id]
  end

  def create
    @image = Image.new(params[:image])
    @image.property_id = session[:property_id]
    @image.user_id = @current_user.id

    if @image.save
      set_main_image_if_first
      redirect_to new_image_path, :notice => 'Image uploaded.'
    else
      render 'new'
    end
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])

    if @image.update_attributes(params[:image])
      flash[:notice] = 'Image saved.'
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    flash[:notice] = 'Image deleted.'
    redirect_to :action => 'index'
  end

  protected

  def set_main_image_if_first
    if @image.property.images.count == 1
      p = @image.property
      p.image_id = @image.id
      p.save
    end
  end
end
