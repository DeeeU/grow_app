# frozen_string_literal: true

class BinaryController < ApplicationController # rubocop:disable Style/Documentation
  skip_before_action :require_login, only: [:index]
  before_action :set_binary, only: %i[show edit update]
  before_action :set_all_tags, only: %i[new create edit update]

  def index
    @binaries = Binary.all
    @search_result = @binaries.search_title(params[:title]).order(:created_at)
  end

  def show; end

  def edit; end

  def update
    process_purge_image
    process_add_tag

    if @binary.update(binary_params)
      flash[:success] = '日記の編集完了'
      redirect_to binary_path(@binary)
    else
      render :edit
    end
  end

  def new
    @binary = Binary.new
  end

  def create
    @binary = Binary.new(binary_params)
    process_add_tag

    if @binary.save
      flash[:success] = '日記の投稿完了'
      redirect_to binary_path(@binary)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    binary = Binary.find(params[:id])
    if binary.delete
      flash[:success] = '日記の削除完了'
      redirect_to binary_index_path
    else
      flash[:error] = '日記の削除失敗'
      render :show
    end
  end

  private

  def set_binary
    @binary = Binary.find(params[:id])
  end

  def set_all_tags
    @tags = Tag.all
  end

  def binary_params
    params.require(:binary).permit(:title, :context, :image, tag_ids: [])
  end

  def process_purge_image
    @binary.image.purge if params[:remove_image] == '1' && @binary.image.attached?
  end

  def process_add_tag
    @binary.add_tag(params[:new_tag]) if params[:new_tag].present? && params[:new_tag][:name].present?
  end
end
