class Admin::UsersController < ApplicationController
  before_filter :admin_required
  layout 'admin'

  before_filter :set_user, only: [:destroy]

  def index
    @users = User.order('email')
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: t('notices.deleted')
  end
  
  private

    def set_user
      @user = User.find(params[:id])
    end
end
