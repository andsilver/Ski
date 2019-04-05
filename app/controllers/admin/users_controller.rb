module Admin
  class UsersController < AdminController
    before_action :set_user, only: [:destroy, :extend_windows]

    def index
      @users = User.order("email")
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: t("notices.deleted")
    end

    def extend_windows
      @user.windows.each do |window|
        window.expires_at += params[:days].to_i.days
        window.save
      end
      redirect_to my_adverts_path(user_id: @user.id)
    end

    private

    def set_user
      @user = User.find(params[:id])
    end
  end
end
