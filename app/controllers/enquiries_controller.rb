class EnquiriesController < ApplicationController
  include SpamProtection

  before_action :user_required, only: [:my, :show]

  def my
    @enquiries = current_user.enquiries
  end

  def show
    @enquiry = Enquiry.find(params[:id])
    not_found && return unless @enquiry.user == @current_user
  end

  def create
    @property = Property.find(params[:enquiry][:property_id])

    @enquiry = Enquiry.new(enquiry_params)

    unless good_token?
      render "properties/contact"
      return
    end

    @enquiry.user = @property.user

    if @enquiry.save
      EnquiryNotifier.notify(@enquiry, @property).deliver_now
      redirect_to @property, notice: t("enquiries_controller.your_enquiry_has_been_sent")
    else
      render "properties/contact"
      return
    end
  end

  protected

  def enquiry_params
    params.require(:enquiry).permit(:comments, :contact_me, :date_of_arrival, :date_of_departure, :email, :name, :number_of_adults, :number_of_children, :number_of_infants, :permission_to_contact, :phone, :property_id)
  end
end
