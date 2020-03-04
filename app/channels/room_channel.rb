class RoomChannel < ApplicationCable::Channel
  def subscribed
     stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    a = Message.create!(content: data['message'])
    template = ApplicationController.renderer.render(partial: 'messages/message', locals: {message:a})
    # room_channel-> room.jsのRoomChannel
    ActionCable.server.broadcast 'room_channel', template
  end
end
