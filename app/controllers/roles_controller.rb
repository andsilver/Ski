class RolesController < ApplicationController
  before_filter :admin_required
  before_filter :find_role, :only => [:edit, :update]

  def index
    @roles = Role.all
  end

  def edit
  end

  def update
    if @role.update_attributes(params[:role])
      redirect_to(roles_path, :notice => 'Saved')
    else
      render "edit"
    end
  end

  protected

  def find_role
    @role = Role.find(params[:id])
  end
end
