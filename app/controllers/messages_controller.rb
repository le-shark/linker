class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
    if !(@conversation.sender_id == current_user.id || @conversation.recipient_id == current_user.id)
      flash[:warning] = "Reading other people's messages is bad, m'kay?"
      redirect_to root_path
    end
  end

  def index
    @messages = @conversation.messages
    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true
      end
    end
    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
    def message_params
      params.require(:message).permit(:text, :user_id)
    end
end
