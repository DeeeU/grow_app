class TagController < ApplicationController

  def edit
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      return true
    else
      render :new
    end
  end

  def delete
  end

  private

  def tag_params
    params.require(:tag).params(:name, :color, :context)
  end
end
