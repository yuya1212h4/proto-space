class LikesController < ApplicationController
  before_action :set_prototype

  def create
    @like = @prototype.likes.create(user_id: current_user.id)
  end

  def destroy
    like = @prototype.likes.find_by(user_id: current_user.id)
    like.destroy
  end

  private
  def set_prototype
    @prototype = Prototype.find(params[:prototype_id])
  end

end
