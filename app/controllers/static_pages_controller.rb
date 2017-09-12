class StaticPagesController < ApplicationController

  def home
    if params[:sort] == "name"
      @communities = Community.all.paginate(page: params[:page], per_page: 30).order('name ASC')
    elsif params[:sort] == "subs"
      @communities = Community.all.sort_by(&:subscribers).reverse.paginate(page: params[:page], per_page: 30)
    elsif params[:sort] == "new"
      @communities = Community.all.paginate(page: params[:page], per_page: 30).order('created_at DESC')
    elsif params[:sort] == "old"
      @communities = Community.all.paginate(page: params[:page], per_page: 30).order('created_at ASC')
    else
      @communities = Community.all.paginate(page: params[:page], per_page: 30).order('bumped_at DESC')
    end
  end
end
