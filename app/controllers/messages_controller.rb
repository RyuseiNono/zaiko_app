class MessagesController < ApplicationController
  before_action :authenticate_user_admin!

  def create
    @message = Message.new(message_params)
    render plain: 'ERROR' and return unless @message.save

    if user_signed_in?
      ActionCable.server.broadcast(
        'message_channel',
        message: @message,
        message_user_name: @message.user.name,
        time: @message.updated_at.strftime('%m/%d %H:%M '),
        message_count: @message.shop.messages.count
      )
    elsif admin_signed_in?
      ActionCable.server.broadcast(
        'message_channel',
        message: @message,
        message_user_name: @message.admin.name,
        time: @message.updated_at.strftime('%m/%d %H:%M '),
        message_count: @message.shop.messages.count
      )
    end
  end

  private

  def message_params
    message_params =
      params.require(:message).permit(:text).merge(shop_id: params[:shop_id])
    if user_signed_in?
      message_params.merge(user_id: current_user.id)
    elsif admin_signed_in?
      message_params.merge(admin_id: current_admin.id)
    end
  end
end
