class RolesController < ApplicationController
  def sales_pitch
    @role = Role.find_by(name: params[:role].gsub('-', ' '))
    not_found and return unless @role
  end
end
