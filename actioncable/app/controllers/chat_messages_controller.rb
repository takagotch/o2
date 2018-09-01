class ChatMessageController < ApplicationController
  def index
    @chat_messages = ChatMessage.all
  end

end


