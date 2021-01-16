class ItemUpdateChannel < ApplicationCable::Channel
  def subscribed
    # stream_from 'item_update_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
