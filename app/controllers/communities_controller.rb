class CommunitiesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def index
    @communities = Community.all.paginate(page: params[:page], per_page: 10).order('name ASC')
  end

  def show
    @community = Community.find(params[:id])
    @posts = @community.posts.paginate(page: params[:page]).order('created_at DESC')
  end

  def new
    @community = Community.new
  end

  def create
    @community =Community.new(community_params)
    if @community.save
      m = Moderation.new(moderator_id: current_user.id, moderated_id: @community.id)
      m.save
      @subscription = Subscription.create
      @subscription.community = @community
      @subscription.user_id = current_user.id
      @subscription.save
      flash[:success] = "Your new community was successfully created!"
      redirect_to @community
    else
      render 'new'
    end
  end

  def edit
    @community = Community.find(params[:id])
    redirect_to @community unless @community.moderators.include? current_user
  end

  def update
    @community = Community.find(params[:id])
    redirect_to @community unless @community.moderators.include? current_user
    if @community.update_attributes(community_params_update)
      flash[:success] = "Community updated"
      redirect_to @community
    else
      render 'edit'
    end
  end

  private
    def community_params
      params.require(:community).permit(:name, :title, :description, :small_description, :rules)
    end

    def community_params_update
      params.require(:community).permit(:title, :description, :small_description, :rules)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:warning] = 'Please log in to access this page'
        redirect_to login_url
      end
    end
end
