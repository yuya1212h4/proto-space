class Prototypes::PopularController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user).page(params[:page]).popular
  end
end
