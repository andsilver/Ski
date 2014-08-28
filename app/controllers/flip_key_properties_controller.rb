class FlipKeyPropertiesController < ApplicationController
  before_action :set_flip_key_property

  def send_message
    check_in  = Date.parse(params[:check_in])
    check_out = Date.parse(params[:check_out])

    validations = [
      User::VALID_EMAIL_FORMAT =~ params[:email],
      params[:name].present?,
      params[:phone_number].present?,
      params[:message].present?,
      @flip_key_property.check_in_on?(check_in),
      @flip_key_property.check_in_and_out_on?(check_in, check_out),
      params[:guests].to_i <= @flip_key_property.occupancy
    ]

    redirect_to @flip_key_property.property and return unless validations.all?

    ms = FlipKey::MessageSender.new(
    check_in: check_in,
    check_out: check_out,
    email: params[:email],
    guests: params[:guests],
    message: params[:message],
    name: params[:name],
    phone_number: params[:phone_number]
    )

    ms.send_message
    redirect_to message_sent_flip_key_property_path(@flip_key_property)
  end

  def message_sent
  end

  private

    def set_flip_key_property
      @flip_key_property = FlipKeyProperty.find(params[:id])
    end
end
