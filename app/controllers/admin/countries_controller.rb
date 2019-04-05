module Admin
  class CountriesController < AdminController
    before_action :set_country, only: [:edit, :update, :destroy]

    def index
      @countries = Country.order("name")
    end

    def new
      @country = Country.new
    end

    def create
      @country = Country.new(country_params)

      if @country.save
        set_image_mode
        redirect_to(new_image_path, notice: t("notices.created"))
      else
        render "new"
      end
    end

    def edit
      set_image_mode
    end

    def update
      if @country.update_attributes(country_params)
        redirect_to(edit_admin_country_path(@country), notice: t("notices.saved"))
      else
        render "edit"
      end
    end

    def show
      @heading_a = @country.name
      default_page_title(@heading_a)

      @featured_properties = @country.featured_properties(9)
    end

    def destroy
      @errors = []
      @errors << "This country has orders associated with it. " unless @country.orders.empty?
      @errors << "This country has order lines associated with it. " unless @country.order_lines.empty?
      @errors << "This country has resorts associated with it. " unless @country.resorts.empty?
      @errors << "This country has users associated with it. " unless @country.users.empty?
      if @errors.empty?
        @country.destroy
        redirect_to admin_countries_path, notice: t("notices.deleted")
      else
        redirect_to admin_countries_path, notice: "This country could not be deleted because: " +
          @errors.join
      end
    end

    protected

    def set_country
      @country = Country.find_by(slug: params[:id])
    end

    def set_image_mode
      session[:image_mode] = "country"
      session[:country_id] = @country.id
    end

    def country_params
      params.require(:country).permit(:image_id, :in_eu, :info, :iso_3166_1_alpha_2, :name, :popular_billing_country, :slug)
    end
  end
end
