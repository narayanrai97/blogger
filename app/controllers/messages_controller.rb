require 'exponent-server-sdk'

class MessagesController < ApplicationController
  before_action :set_message, only: [:edit, :update, :destroy, :post, :unpost]

  def index
    @messages = Message.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      flash[:notice] = "Message created."
      redirect_to messages_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @message.update_attributes(message_params)
      flash[:notice] = "Message updated."
      redirect_to messages_path
    else
      render 'edit'
    end
  end

  def destroy
    @message.destroy
    flash[:success] = "Message deleted."
    redirect_to messages_path
  end

  def post
    @message.update_attributes(posted: true)
    devices = Device.all

    client = Exponent::Push::Client.new
    messages = []
    devices.each do |device|
      message = {
        to: device.token,
        sound: "default",
        body: @message.title
      }
      messages << message
    end

    client.publish messages

    flash[:notice] = "Message posted."
    redirect_to request.referrer || messages_path
  end

  def unpost
    @message.update_attributes(posted: false)
    flash[:notice] = "Message unposted."
    redirect_to request.referrer || messages_path
  end



  private

    def message_params
      params.require(:message).permit(:title, :body, :posted, :message_type, :titulo, :cuerpo)
    end

    def set_message
      @message = Message.find(params[:id])
    end
end
