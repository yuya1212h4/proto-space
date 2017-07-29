class PrototypesController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user)
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
    @prototype = Prototype.find(params[:id])
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    @prototype.prototype_images
    if @prototype.user_id == current_user.id
      binding
      @prototype.update(prototype_params)
      redirect_to root_path, notice: 'Prototype was successfully updated.'
    else
      flash[:alert] = 'Prototype do not update.'
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    if @prototype.user_id == current_user.id
      @prototype.destroy
      redirect_to root_path, notice: 'Prototype was successfully deleted.'
    else
      flash[:alert] = 'Prototype do not delete.'
      render :new
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :text, prototype_images_attributes: [:id, :image, :image_type]).merge(user_id: current_user.id)
  end

end
