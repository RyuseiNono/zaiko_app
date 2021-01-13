class ItemCreateChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'item_create_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
