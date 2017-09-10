class CommunitiesController < ApplicationController
  def show
    @community = Community.find(params[:id])
    @posts = @community.posts.paginate(page: params[:page]).order('created_at DESC')
  end
end
