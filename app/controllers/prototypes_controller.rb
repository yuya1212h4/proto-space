class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]

  def index
    @prototypes = Prototype.includes(:user).page(params[:page])
  end

  def new
    @prototype = Prototype.new
    @prototype.prototype_images.build
  end

  def create
    @prototype = current_user.prototypes.new(prototype_params)
    if @prototype.save
      redirect_to root_path, notice: 'Successful posting of prototype.'
    else
      flash[:alert] = 'prototype do not create'
      # FIXME: creteに失敗してリロードを行うとエラーになる
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to root_path, notice: 'Prototype was successfully updated.'
    else
      flash[:alert] = 'Prototype do not update.'
      render :edit
    end
  end

  def destroy
    if @prototype.user_id == current_user.id
      @prototype.destroy
      redirect_to root_path, notice: 'Prototype was successfully deleted.'
    else
      flash[:alert] = 'Prototype do not delete.'
      render :index
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :text, prototype_images_attributes: [:id, :image, :image_type])
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
end
