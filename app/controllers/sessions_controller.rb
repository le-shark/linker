class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where("lower(username) = ?", params[:session][:username].downcase).first
    if user && user.authenticate(params[:session][:password])
      flash[:info] = "Welcome back, #{user.username}!"
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:error] = "Invalid username/password. Please try again."
      render 'new'
    end
  end

  def destroy
    flash[:info] = "See you!"
    session[:return_to] ||= request.referer
    log_out if logged_in?
    redirect_to session.delete(:return_to)
  end
end
