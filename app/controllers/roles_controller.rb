class RolesController < ApplicationController
  def sales_pitch
    @role = Role.find_by(name: params[:role].tr("-", " "))
    not_found && return unless @role
  end
end
