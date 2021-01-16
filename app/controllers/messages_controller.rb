class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    retuen unless @message.save
    if user_signed_in?
      ActionCable.server.broadcast('message_channel', message: @message, message_user_name: @message.user.name, time: @message.updated_at.strftime("%m/%d %H:%M "), message_count: @message.shop.messages.count)
    elsif admin_signed_in?
      ActionCable.server.broadcast('message_channel', message: @message, message_user_name: @message.admin.name, time: @message.updated_at.strftime("%m/%d %H:%M "), message_count: @message.shop.messages.count)
    end
  end

  def destroy

  end

  private
  def message_params
    message_params = params.require(:message).permit(:text).merge(shop_id: params[:shop_id])
    if user_signed_in?
      return merge_user_id(message_params)
    elsif admin_signed_in?
      return merge_admin_id(message_params)
    end
  end

  def merge_user_id(message_params)
    return message_params.merge(user_id: current_user.id)
  end

  def merge_admin_id(message_params)
    return message_params.merge(admin_id: current_admin.id)
  end

end
