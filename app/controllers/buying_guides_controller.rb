class BuyingGuidesController < ApplicationController
  before_action :set_buying_guide

  def show
    @featured_properties = @buying_guide.country.featured_properties(9)
  end

  protected

  def set_buying_guide
    @buying_guide = BuyingGuide.find_by(id: params[:id])
    not_found unless @buying_guide
  end
end
