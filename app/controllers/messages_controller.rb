class MessagesController < ApplicationController
  before_action :logged_in_user
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
    if !(@conversation.sender_id == current_user.id || @conversation.recipient_id == current_user.id)
      flash[:warning] = "Reading other people's messages is bad, m'kay?"
      redirect_to root_path
    end
  end

  after_action :mark_as_read, only: :index

  def index
    @messages = @conversation.messages.paginate(page: params[:page], per_page: 20).order('created_at ASC')
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
    def mark_as_read
      @messages.each do |msg|
        if msg.user_id != current_user.id
          msg.read = true
          msg.save
        end
      end
    end

    def message_params
      params.require(:message).permit(:text, :user_id)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:warning] = 'Please log in to access this page'
        redirect_to login_url
      end
    end
end
