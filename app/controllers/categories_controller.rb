# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_resort, only: [:show]
  before_action :set_category, only: [:show]

  def show
    not_found unless @resort.visible? || admin?

    @heading_a = "#{t(@category.name)} in #{@resort}, #{@resort.country.name}"
    default_page_title(@heading_a)

    @directory_adverts = directory_adverts

    not_found unless @directory_adverts.any?
  end

  protected

  def set_resort
    @resort = Resort.find_by(slug: params[:resort_slug])
    not_found unless @resort
  end

  def set_category
    @category = Category.find_by(id: params[:id]) ||
      redirect_to(:root, notice: t("categories_controller.not_found"))
  end

  def directory_adverts
    DirectoryAdvert.advertised_in(@category, @resort)
      .order(Arel.sql("RAND()"))
      .paginate(page: params[:page])
  end
end
