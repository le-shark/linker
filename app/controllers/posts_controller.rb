class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :upvote, :downvote, :gild]

  def show
    @post = Post.find(params[:id])
  end

  def new
    @community = Community.find(params[:id])
    @post = Post.new
  end

  def gild
    @post = Post.find(params[:post_id])
    if @post.user.id == current_user.id
      flash[:warning] = "You can't gild your own posts!"
      redirect_to request.referer
      return
    end
    @post.gild
    flash[:success] = "Let's pretend that you paid $3 to gild this post"
    redirect_to request.referer
  end

  def create
    @community = Community.find(params[:id])
    @post = @community.posts.build(post_params)
    @post.user = current_user
    if @post.save
      @post.upvote_by current_user
      flash[:success] = "Successfully submitted a new post!"
      redirect_to community_post_path(@community, @post)
    else
      render 'new', params: { textpost: params[:textpost] }
    end
  end

  def upvote
    @post = Post.find(params[:id])
    if current_user.disliked? @post
      @post.undisliked_by current_user
      @post.user.increase_post_karma
    end
    @post.upvote current_user
    redirect_to request.referer
  end

  def downvote
    @post = Post.find(params[:id])
    if current_user.liked? @post
      @post.unliked_by current_user
      @post.user.decrease_post_karma
    end
    @post.downvote current_user
    redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:title, :type, :text, :link)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:warning] = 'You must be logged in to do that'
      redirect_to login_url
    end
  end
end
