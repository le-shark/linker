class SavingsController < ApplicationController
  def create
    @saving = Saving.create
    if params[:comment_id]
      @saving.saved_comment_id = params[:comment_id]
      @saving.saved_type = "Comment"
    else
      @saving.saved_post_id = params[:post_id]
      @saving.saved_type = "Post"
    end
    @saving.saver_id = current_user.id
    if @saving.save!
      redirect_to request.referer
    else
      flash[:error] = "What could possibly go wrong with saving?"
      redirect_to request.referer
    end
  end

  def destroy
    @saving = Saving.find(params[:saving_id])
    if current_user.saved_posts.include? @saving
      @saving.delete
      redirect_to request.referer
    else
      flash[:error] = "Can't unsave the unsaved!"
      redirect_to request.referer
    end
  end

  private
    def saving_params
      params.require(:saving).permit(:saved_type, :saver_id, :saved_post_id, :saved_comment_id)
    end
end
