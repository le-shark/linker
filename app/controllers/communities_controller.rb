class CommunitiesController < ApplicationController
  def show
    @community = Community.find(params[:id])
    @posts = @community.posts.reverse
  end
end
