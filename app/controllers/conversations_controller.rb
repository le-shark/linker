class ConversationsController < ApplicationController
  before_action :logged_in_user

  def index
    @conversations = Conversation.where("conversations.sender_id = ? OR conversations.recipient_id = ?",
                     current_user.id, current_user.id)
  end

  def create
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end

    redirect_to conversation_messages_path(@conversation)
  end

  private
    def conversation_params
      params.permit(:sender_id, :recipient_id)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:warning] = 'Please log in to access this page'
        redirect_to login_url
      end
    end
end
