module Admin
  class CategoriesController < AdminController
    before_action :set_category, only: [:edit, :update, :show, :destroy]

    def index
      @categories = Category.order("name")
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)

      if @category.save
        redirect_to(admin_categories_path, notice: t("notices.created"))
      else
        render action: "new"
      end
    end

    def edit
    end

    def update
      if @category.update_attributes(category_params)
        redirect_to(admin_categories_path, notice: t("notices.saved"))
      else
        render action: "edit"
      end
    end

    def destroy
      @category.destroy

      redirect_to(admin_categories_path, notice: t("notices.deleted"))
    end

    protected

    def set_category
      @category = Category.find_by(id: params[:id])
      redirect_to(:root, notice: t("categories_controller.not_found")) unless @category
    end

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
