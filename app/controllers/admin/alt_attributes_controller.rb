module Admin
  class AltAttributesController < AdminController
    before_action :set_alt_attribute, only: [:edit, :update, :show, :destroy]

    def index
      @alt_attributes = AltAttribute.order("path")
    end

    def new
      @alt_attribute = AltAttribute.new
    end

    def create
      @alt_attribute = AltAttribute.new(alt_attribute_params)

      if @alt_attribute.save
        redirect_to(admin_alt_attributes_path, notice: t("notices.created"))
      else
        render "new"
      end
    end

    def edit
    end

    def update
      if @alt_attribute.update_attributes(alt_attribute_params)
        redirect_to(admin_alt_attributes_path, notice: t("notices.saved"))
      else
        render "edit"
      end
    end

    def destroy
      @alt_attribute.destroy
      redirect_to admin_alt_attributes_path, notice: t("notices.deleted")
    end

    protected

    def set_alt_attribute
      @alt_attribute = AltAttribute.find(params[:id])
    end

    def alt_attribute_params
      params.require(:alt_attribute).permit(:alt_text, :path)
    end
  end
end
