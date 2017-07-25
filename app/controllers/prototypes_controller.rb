class PrototypesController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user).all
  end

  def new
    @prototype = Prototype.new
    @prototype.prototype_images.build
  end

  def create
    @prototype = current_user.prototypes.new(prototype_params)
    if @prototype.save
      redirect_to prototype_path(@prototype)
    else
      flash[:alert] = 'prototype do not create'
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
  end

  def edit
  end

  def update
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :text, prototype_images_attributes: [:image, :image_type])
  end

end
