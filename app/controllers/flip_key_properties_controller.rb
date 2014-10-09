class FlipKeyPropertiesController < ApplicationController
  before_action :set_flip_key_property

  def send_message
    check_in  = Date.parse(params[:check_in])
    check_out = Date.parse(params[:check_out])

    validations = [
      User::VALID_EMAIL_FORMAT =~ params[:email],
      params[:name].present?,
      params[:phone_number].present?,
      params[:comment].present?,
      @flip_key_property.check_in_on?(check_in),
      @flip_key_property.check_in_and_out_on?(check_in, check_out),
      params[:guests].to_i <= @flip_key_property.occupancy
    ]

    redirect_to @flip_key_property.property and return unless validations.all?

    details = {
      check_in: check_in,
      check_out: check_out,
      comment: params[:comment],
      email: params[:email],
      guests: params[:guests],
      name: params[:name],
      phone_number: params[:phone_number],
      property_id: @flip_key_property.provider_property_id,
      user_ip: request.remote_ip
    }
    ms = FlipKey::MessageSender.new(details)

    if ms.send_message
      save_copy_as_enquiry(details)
      redirect_to message_sent_flip_key_property_path(@flip_key_property)
    else
      redirect_to @flip_key_property.property
    end
  end

  def message_sent
  end

  private

    def set_flip_key_property
      @flip_key_property = FlipKeyProperty.find(params[:id])
    end

    # Creates a copy of the FlipKey message as an enquiry under the FlipKey
    # user's account, allowing the site owner to reconcile enquiries with
    # affiliate payments.
    def save_copy_as_enquiry(details)
      Enquiry.create!(
        user_id:           FlipKey::user.id,
        date_of_arrival:   details[:check_in],
        date_of_departure: details[:check_in],
        email:             details[:email],
        name:              details[:name],
        phone:             details[:phone_number],
        property_id:       @flip_key_property.property.id, 
        comments:          details.map{|k,v| "#{k}:\n#{v}"}.join("\n\n")
      )
    end
end
