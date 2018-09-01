class ChatMessageBroadcastJob < Application
  queue_as :default

  def perform(*arg)
	  ActionCable.server.broadcast 'chat_message_channel', message: chat_message.body
  end
end

