module ResortSetter
  extend ActiveSupport::Concern

  def set_resort_with slug_or_id
    @resort = Resort.find_by(slug: slug_or_id)

    # Handle legacy resort URLs
    unless @resort
      @resort = Resort.find_by(id: slug_or_id)
      redirect_to(@resort, status: 301) && return if @resort
    end

    if admin?
      redirect_to(admin_resorts_path, notice: t("resorts_controller.not_found")) unless @resort
    else
      not_found if !@resort || !@resort.visible?
    end
  end
end
