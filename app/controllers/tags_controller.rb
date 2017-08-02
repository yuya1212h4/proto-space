class TagsController < ApplicationController
  def index
    @tags = Prototype.all_tags
  end

  def show
    @prototypes = Prototype.tagged_with(params[:id])
  end

end
