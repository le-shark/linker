class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :upvote, :downvote, :gild, :destroy]

  def show
    @post = Post.find(params[:id])
    if params[:sort] == "old"
      @comments = @post.comments.paginate(page: params[:page], per_page: 20).order('created_at ASC')
    elsif params[:sort] == "top"
      @comments = @post.comments.paginate(page: params[:page], per_page: 20).order('cached_votes_total DESC')
    else
      @comments = @post.comments.paginate(page: params[:page], per_page: 20).order('created_at DESC')
    end
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

  def new
    @community = Community.find(params[:id])
    @post = Post.new
  end

  def create
    @community = Community.find(params[:id])
    @post = @community.posts.build(post_params)
    @post.user = current_user
    if @post.save
      @community.bump
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
    @community = @post.community
    if current_user.admin? || @post.community.moderators.include?(current_user) || @post.user == current_user
      @post.delete
      flash[:success] = "Post deleted"
    else
      flash[:warning] = "You are not authorized to do that"
    end
    redirect_to @community
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params_edit)
      flash[:success] = "Post updated"
      redirect_to community_post_path(@post.community, @post)
    else
      render 'edit'
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :type, :text, :link)
  end

  def post_params_edit
    params.require(:post).permit(:title, :text, :link)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:warning] = 'You must be logged in to do that'
      redirect_to login_url
    end
  end
end
