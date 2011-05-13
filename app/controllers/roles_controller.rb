class RolesController < ApplicationController
  before_filter :admin_required, :except => [:sales_pitch]
  before_filter :find_role, :only => [:edit, :update]
  before_filter :no_browse_menu

  def index
    @roles = Role.all
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(params[:role])

    if @role.save
      redirect_to(roles_path, :notice => 'Role created.')
    else
      render "new"
    end
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

  def sales_pitch
    @role = Role.find_by_name(params[:role].gsub('-', ' '))
    not_found unless @role
  end

  protected

  def find_role
    @role = Role.find(params[:id])
  end
end
