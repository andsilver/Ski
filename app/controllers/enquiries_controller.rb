class EnquiriesController < ApplicationController
  include SpamProtection

  before_filter :user_required, only: [:my]
  before_filter :no_browse_menu

  def my
    @enquiries = @current_user.enquiries
  end

  def create
    @property = Property.find(params[:enquiry][:property_id])

    @enquiry = Enquiry.new(params[:enquiry])

    unless good_token?
      render 'properties/contact'
      return
    end

    @enquiry.user = @property.user

    if @enquiry.save
      EnquiryNotifier.notify(@enquiry, @property).deliver
      redirect_to @property, notice: t('enquiries_controller.your_enquiry_has_been_sent')
    else
      render 'properties/contact'
      return
    end
  end
end
