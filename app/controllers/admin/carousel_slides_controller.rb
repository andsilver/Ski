module Admin
  class CarouselSlidesController < AdminController
    before_action :set_carousel_slide, only: [:edit, :update, :destroy, :move_up, :move_down]

    def index
      @carousel_slides = CarouselSlide.order(:position)
    end

    def new
      @carousel_slide = CarouselSlide.new(active_until: DateTime.now + 5.years)
    end

    def edit
    end

    def create
      @carousel_slide = CarouselSlide.new(carousel_slide_params)

      if @carousel_slide.save
        redirect_to admin_carousel_slides_path, notice: t("notices.added")
      else
        render :new
      end
    end

    def update
      if @carousel_slide.update_attributes(carousel_slide_params)
        redirect_to admin_carousel_slides_path, notice: t("notices.saved")
      else
        render :edit
      end
    end

    def destroy
      @carousel_slide.destroy
      redirect_to admin_carousel_slides_path, notice: t("notices.deleted")
    end

    def move_up
      @carousel_slide.move_higher
      moved
    end

    def move_down
      @carousel_slide.move_lower
      moved
    end

    private

    def set_carousel_slide
      @carousel_slide = CarouselSlide.find_by(id: params[:id])
      not_found unless @carousel_slide
    end

    def carousel_slide_params
      params.require(:carousel_slide).permit(:active_from, :active_until, :alt, :caption, :image_url, :link, :position)
    end

    def moved
      flash[:notice] = t("notices.moved")
      redirect_to action: "index"
    end
  end
end
