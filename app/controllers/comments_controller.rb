class CommentsController < ApplicationController
before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user
    if @comment.save
      redirect_to request.referer
    else
      redirect_to request.referer, notice: "Your comment wasn't posted!"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
  end
end
