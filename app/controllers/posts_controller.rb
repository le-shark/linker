class PostsController < ApplicationController
  before_action :confirm_logged_in, only: [:new, :create]

  def show
    @post = Post.find(params[:id])
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
      redirect_to @community
    else
      render 'new', params: { textpost: params[:textpost] }
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :type, :text, :link)
  end

  def confirm_logged_in
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to) if !logged_in?
  end
end
