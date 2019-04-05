# frozen_string_literal: true

class ResortsController < ApplicationController
  include ResortSetter

  before_action :set_resort, only: [:directory, :feature, :gallery,
                                    :how_to_get_there, :piste_map, :piste_map_full_size, :resort_guide,
                                    :show, :ski_and_guiding_schools, :summer_holidays,]
  before_action :find_featured_properties, only: [:resort_guide, :show, :summer_holidays, :logo_title, :logo_url, :logo_title]

  def show
    default_page_title t("resorts_controller.titles.show", resort: @resort, country: @resort.country)
    default_meta_description(resort: @resort, country: @resort.country)
    @heading = t("resorts_controller.resort_information_heading", resort: @resort)
  end

  def resort_guide
    default_page_title t("resorts_controller.titles.resort_guide", resort: @resort, country: @resort.country)
    default_meta_description(resort: @resort, country: @resort.country)
    @heading = t("resorts_controller.detail.more_detail")
  end

  def directory
    @heading = t("resorts_controller.titles.directory", resort: @resort, country: @resort.country)
    default_page_title @heading
    default_meta_description(resort: @resort, country: @resort.country)
    @categories = Category.order("name")
  end

  def featured
    @heading_a = t("featured_resorts")
  end

  def piste_map
    default_page_title t("resorts_controller.titles.piste_map", resort: @resort, country: @resort.country)
    default_meta_description(resort: @resort, country: @resort.country)
    @heading = t("piste_map")
    render :piste_map, status: @resort.has_piste_maps? ? 200 : 404
  end

  def piste_map_full_size
    default_meta_description(resort: @resort, country: @resort.country)
    @map = params[:map]
    render layout: nil
  end

  def gallery
    default_page_title t("resorts_controller.titles.gallery", resort: @resort, country: @resort.country)
    @heading = t("gallery")
  end

  def feature
  end

  def ski_and_guiding_schools
    not_found unless admin? || page_info.try(:visible?)
  end

  def summer_holidays
    not_found unless admin? || page_info.try(:visible?)
  end

  def how_to_get_there
  end

  protected

  def set_resort
    set_resort_with params[:id]
  end

  def find_featured_properties
    @featured_properties = Property.order(Arel.sql("RAND()"))
      .limit(9)
      .where(
        publicly_visible: true,
        resort_id: @resort.id
      )
  end
end
