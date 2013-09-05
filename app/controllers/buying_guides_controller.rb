class BuyingGuidesController < ApplicationController
  before_action :set_buying_guide

  def show
    @featured_properties = @buying_guide.country.featured_properties(9)
  end

  protected

    def set_buying_guide
      @buying_guide = BuyingGuide.find_by(id: params[:id])
      if admin?
        redirect_to(admin_buying_guides_path) unless @buying_guide
      else
        not_found if !@buying_guide
      end
    end
end
