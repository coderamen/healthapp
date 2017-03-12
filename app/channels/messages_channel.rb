class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_from_match#{params[:match_id]}"
  end

end