require 'exponent-server-sdk'

class Api::V1::DevicesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    message = " "
    @device = Device.where(token: params[:device][:token]).first

    if @device.blank?
      @device = Device.create(device_params)
      message = 'Hello there! This is a push notification.'
      # json_response(@device, :created)

      exponent.publish(
        exponentPushToken: @device.token,
        message: message,
        data: {a: 'b'},
      )

      render json: {success: true}
    end
  end


  private

    def device_params
      params.permit(:token)
    end

    def exponent
      @exponent ||= Exponenet::Push::Client.new
    end
end
