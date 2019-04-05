module Admin
  class AdminController < ApplicationController
    before_action :admin_required
    layout "admin"
  end
end
