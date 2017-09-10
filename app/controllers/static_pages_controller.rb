class StaticPagesController < ApplicationController
  def home
    if current_user
      @posts = current_user.feed.paginate(page: params[:page]).order('created_at DESC')
    else
      @posts = Post.all.paginate(page: params[:page]).order('created_at DESC')
    end
  end
end
