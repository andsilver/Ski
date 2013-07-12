class CountriesController < ApplicationController
  before_action :set_country, only: [:show]
  before_action :protect_country, only: [:show]

  def show
    @heading_a = @country.name
    default_page_title(@heading_a)
    @banner_advert_html ||= @country.banner_advert_html

    @featured_properties = @country.featured_properties(9)
  end

  protected

    def set_country
      @country = Country.find_by(slug: params[:id])
      not_found unless @country
    end

    def protect_country
      not_found if @country.visible_resorts.empty? and !admin?
    end
end
