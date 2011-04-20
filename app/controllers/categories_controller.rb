class CategoriesController < ApplicationController
  before_filter :no_browse_menu
  before_filter :admin_required, :except => [:index, :show]
  before_filter :find_resort, :only => [:index, :new]
  before_filter :find_category, :only => [:edit, :update, :show, :destroy]

  def index
    @categories = @resort.categories
  end

  def new
    @category = Category.new
    @category.resort_id = @resort.id
  end

  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to(resort_categories_path(@category.resort), :notice => 'Category created.') }
        format.xml  { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to(resort_categories_path(@category.resort), :notice => 'Saved') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(resort_categories_path(@category.resort), :notice => 'Category deleted.') }
      format.xml  { head :ok }
    end
  end

  protected

  def find_resort
    @resort = Resort.find(params[:resort_id])
  end

  def find_category
    @category = Category.find_by_id(params[:id])
    redirect_to(:root, :notice => 'That category does not exist.') unless @category
  end
end
