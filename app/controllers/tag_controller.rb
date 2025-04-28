# frozen_string_literal: true

class TagController < ApplicationController
  def edit; end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    return true if @tag.save

    render :new
  end

  def delete; end

  private

  def tag_params
    params.require(:tag).params(:name, :color, :context)
  end
end
