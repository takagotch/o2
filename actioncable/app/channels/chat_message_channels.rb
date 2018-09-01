class ChatMessageChannel < ApplicationCable:Channel
  def speak(data)
    ChatMessage.create! body: data['msg']
  end
end

