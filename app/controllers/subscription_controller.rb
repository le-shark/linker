class SubscriptionController < ApplicationController
  before_action :logged_in_user

  def create
    @subscription = Subscription.create
    @subscription.community = Community.find(params[:id])
    @subscription.user_id = current_user.id
    if @subscription.save!
      flash[:success] = "Subscribed #{@subscription.community.name}"
      redirect_to request.referer
    else
      flash[:error] = "What could possibly go wrong with subscribing?"
      redirect_to request.referer
    end
  end

  def destroy
    @subscription = Subscription.where(community_id: Community.find(params[:id]).id, user_id: current_user.id).first
    if current_user.subscriptions.include? @subscription
      flash[:success] = "Unsubscribed #{@subscription.community.name}"
      @subscription.delete
      redirect_to request.referer
    else
      flash[:error] = "Can't unsubscribe the unsubscribable!"
      redirect_to request.referer
    end
  end

  private
    def logged_in_user
      unless logged_in?
        store_location
        flash[:warning] = 'You must be logged in to do that'
        redirect_to login_url
      end
    end
end
