class CommentsController < ApplicationController
before_action :find_commentable
before_action :logged_in_user

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user
    if @comment.save
      @comment.upvote_by current_user
      redirect_to request.referer
    else
      redirect_to request.referer, notice: "Your comment wasn't posted!"
    end
  end

  def upvote
    @comment = Comment.find(params[:id])
    if current_user.disliked? @comment
      @comment.undisliked_by current_user
      @comment.user.increase_post_karma
    end
    @comment.upvote current_user
    redirect_to request.referer
  end

  def downvote
    @comment = Comment.find(params[:id])
    if current_user.liked? @comment
      @comment.unliked_by current_user
      @comment.user.decrease_post_karma
    end
    @comment.downvote current_user
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:warning] = 'You must be logged in to do that'
      redirect_to login_url
    end
  end
end
