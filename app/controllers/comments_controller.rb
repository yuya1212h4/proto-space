class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.create(comment_params)
    @comments = Prototype.find(params[:prototype_id]).comments.includes(:user)
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(prototype_id: params[:prototype_id])
  end
end
