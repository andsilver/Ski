class CategoriesController < ApplicationController
  before_action :admin_required, except: [:show]
  layout 'admin', except: [:show]

  before_action :set_resort, only: [:show]
  before_action :find_category, only: [:edit, :update, :show, :destroy]

  def index
    @categories = Category.order('name')
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to(categories_path, notice: t('notices.created'))
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      redirect_to(categories_path, notice: t('notices.saved'))
    else
      render action: 'edit'
    end
  end

  def show
    not_found unless @resort.visible? or admin?

    @heading_a = "#{t(@category.name)} in #{@resort}, #{@resort.country.name}"
    default_page_title(@heading_a)

    @directory_adverts = DirectoryAdvert
      .advertised_in(@category, @resort)
      .order('RAND()')
      .paginate(page: params[:page])

    not_found unless @directory_adverts.any?
  end

  def destroy
    @category.destroy

    redirect_to(categories_path, notice: t('notices.deleted'))
  end

  protected

    def set_resort
      @resort = Resort.find_by(slug: params[:resort_slug])
      not_found unless @resort
    end

  def find_category
    @category = Category.find_by(id: params[:id])
    redirect_to(:root, notice: t('categories_controller.not_found')) unless @category
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
