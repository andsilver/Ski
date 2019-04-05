module Admin
  class RolesController < AdminController
    before_action :set_role, only: [:edit, :update]

    def index
      @roles = Role.all
    end

    def new
      @role = Role.new
    end

    def create
      @role = Role.new(role_params)

      if @role.save
        redirect_to(admin_roles_path, notice: t("notices.created"))
      else
        render "new"
      end
    end

    def edit
    end

    def update
      if @role.update_attributes(role_params)
        redirect_to(edit_admin_role_path(@role), notice: t("notices.saved"))
      else
        render "edit"
      end
    end

    protected

    def set_role
      @role = Role.find(params[:id])
    end

    def role_params
      params.require(:role).permit(:admin, :advertises_properties_for_rent,
        :advertises_properties_for_sale, :advertises_generally,
        :advertises_through_windows, :flag_new_development,
        :has_a_website, :has_business_details, :name,
        :new_development_by_default, :sales_pitch, :select_on_signup)
    end
  end
end
