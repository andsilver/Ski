class UploadsController < ApplicationController
  before_filter :admin_required, :no_browse_menu

  UPLOADS_DIRECTORY = "#{Rails.root.to_s}/public/uploads/"

  def index
    @heading_a = '<a href="/cms">CMS</a> &rarr; Uploads'.html_safe
    @uploads = Dir.entries(UPLOADS_DIRECTORY).select {|e| e[0..0] != "."}
  end

  def create
    file_data = params[:file]

    if file_data.nil? or (file_data.kind_of? String and file_data.empty?)
      flash[:notice] = 'Sorry, your file was not uploaded properly.'
    else
      path = UPLOADS_DIRECTORY + file_data.original_filename
      File.open(path, "wb") { |file| file.write(file_data.read) }
      flash[:notice] = 'New file uploaded.'
    end
    redirect_to uploads_path
  end

  def delete_file
    f = UPLOADS_DIRECTORY + File.basename(params[:filename])
    if File.exists? f
      File.unlink f
    end
    redirect_to uploads_path, :notice => 'Deleted.'
  end
end
